'use strict';

var resourcesToBackend = function resourcesToBackend(res) {
  return {
    type: 'backend',
    init: function init(services, backendOptions, i18nextOptions) {},
    read: function read(language, namespace, callback) {
      if (typeof res === 'function') {
        res(language, namespace, callback);
        return;
      }

      callback(null, res && res[language] && res[language][namespace]);
    }
  };
};

module.exports = resourcesToBackend;
