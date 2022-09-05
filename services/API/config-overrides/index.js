const {
    override,
    addWebpackAlias
} = require('customize-cra');

const path = require("path");
 
 module.exports = override(
    addWebpackAlias({
        '@config': path.resolve(__dirname, '../src/config/'),
        '@migrations': path.resolve(__dirname, '../src/migrations/'),
        '@models': path.resolve(__dirname, '../src/models/'),
        '@seeders': path.resolve(__dirname, '../src/seeders/'),
    }),
);
