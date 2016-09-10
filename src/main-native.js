/**
 * @overview Native-Elm bindings
 */
'use strict';

const delayProxy = (time) => (fn) => setTimeout(fn, time);

const getView = (id) => document.getElementById(id);
const getContent = (view) => view.getWebContents();
const getSession = (view) => getContent(view).session;
const getDebugger = (view) => getContent(view).debugger;

const getWebviewObjects = (view) => ({
  view,
  contents: getContent(view),
  session: getSession(view),
  debug: getDebugger(view)
});

const attachDebugger = (state, debug) => {
  try {
    debug.attach('1.1');
    return true;
  }
  catch (err) {
    console.info('Attaching debugger failed.\n', err);
    return false;
  }
}

const delay = delayProxy(50);

const bindPorts = module.exports.bindPorts = (ports) => {
  console.log('Binding ports');
  ports.startApp.subscribe((state) => {
    console.group('startApp');
    console.log('state =>', state);
    console.groupEnd();
    delay(() => {
      const { view, contents, session, debug } = getWebviewObjects(getView(state.webviewId));

      if (!state.debugger) {
        // Enable debugger in our state
        try {
          contents.debugger.attach('1.1');
          ports.debuggerState.send(true);
        }
        catch (err) {
          console.info('Attaching debugger failed.\n', err);
        }
      }

      debug.on('detached', () => {
        ports.debuggerState.send(false);
      });

      debug.on('message', (event, method, params) => {
        // console.log('debug#on `message` => %s', method, { event, params });
        ports.handleEvent.send({ requestId: params.requestId, method, content: null });
      });

      debug.sendCommand('Network.enable');
    });
  })

  ports.debuggerCmdRes.subscribe((cmd) => {
    console.log('ports.debuggerCmdRes =>', cmd);
  })

  ports.debuggerLog.subscribe((msg) => {
    console.log('ports.debuggerLog =>', msg);
  });

  ports.attachDebugger.send('1.1');
};
