const {
    override,
    addWebpackAlias
} = require('customize-cra');

const path = require("path");
 
 module.exports = override(
    addWebpackAlias({
        '@src': path.resolve(__dirname, '../src/'),
        '@assets': path.resolve(__dirname, '../src/assets'),
        '@components': path.resolve(__dirname, '../src/components/'),
        '@constants': path.resolve(__dirname, '../src/constants/'),
        '@domain': path.resolve(__dirname, '../src/domain/'),
        '@redux': path.resolve(__dirname, '../src/redux/'),
        '@services': path.resolve(__dirname, '../src/services/'),
        '@store': path.resolve(__dirname, '../src/store/'),
        '@usecases': path.resolve(__dirname, '../src/usecases/'),
        '@container-inversify': path.resolve(__dirname, '../src/inversify.config.ts'),
    }),
);
