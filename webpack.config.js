const path = require("path");
const nodeExternals = require("webpack-node-externals");
const slsw = require("serverless-webpack");

module.exports = {
    entry: slsw.lib.entries,
    target: "node",
    watch: true,
    watchOptions: {
        ignored: /node_modules/,
        aggregateTimeout: 200,
        poll: 1000,
    },
    node: {
        __dirname: false,
    },
    mode: process.env.IS_OFFLINE ? "none" : slsw.lib.webpack.isLocal ? "development" : "production",
    externals: [nodeExternals()],
    output: {
        libraryTarget: "commonjs2",
        path: path.join(__dirname, ".webpack"),
        filename: "[name].js",
    },
    module: {
        rules: [
            {
                parser: {
                    amd: false,
                },
            },
            {
                test: /\.js$/,
                use: [
                    {
                        loader: "babel-loader",
                        options: {
                            // ... and this
                            presets: [["@babel/env", { targets: { node: "16.7.0" } }]],
                            plugins: ["@babel/plugin-proposal-object-rest-spread"],
                        },
                    },
                ],
                exclude: /node_modules/,
            },
            {
                test: /\.(graphql|gql)$/,
                exclude: /node_modules/,
                loader: "graphql-tag/loader",
            },
        ],
    },
    optimization: {
        minimize: !slsw.lib.webpack.isLocal,
    },
    devtool: "source-map",
    stats: "minimal",
};
