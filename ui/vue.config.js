module.exports = {
  devServer: {
    port: 8081,
    disableHostCheck: true,
  },
  configureWebpack: {
    output: {
      hashFunction: "xxhash64"
    }
  },
  transpileDependencies: [
    "vuetify"
  ],
  pwa: {
    name: 'Wg Gen Web',
  }
};
