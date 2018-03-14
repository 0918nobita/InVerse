module.exports = env => {
    let config = {
        entry: './src/index.js',
        output: {
            filename: 'bundle.js'
        },
        mode: 'development',
        devServer: {
            contentBase: 'dist',
            open: true
        }
    };
    if (env !== void 0 && env.production !== void 0) config.mode = 'production';
    return config;
};
