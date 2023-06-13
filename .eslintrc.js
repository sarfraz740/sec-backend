module.exports = {
    env: {
        browser: true,
        es2021: true,
        node: true,
        jest: true,
    },
    extends: ["eslint:recommended", "eslint-config-airbnb-base", "plugin:prettier/recommended"],
    globals: {
        // TODO remove `node-fetch` module with node.js v18+ support
        // TODO file bug with eslint? those should be global now
        fetch: true,
        Headers: true,
    },
    parserOptions: {
        ecmaVersion: "latest",
        sourceType: "module",
    },

    rules: {
        //* Avoid Bugs
        "no-undef": "error",
        semi: "error",
        "semi-spacing": "error",

        //* Best Practices
        eqeqeq: "warn",
        "no-invalid-this": "error",
        "no-return-assign": "error",
        "no-unused-expressions": ["error", { allowTernary: true }],
        "no-useless-concat": "error",
        "no-useless-return": "error",
        "no-constant-condition": "warn",
        "no-unused-vars": ["warn", { argsIgnorePattern: "req|res|next|__" }],

        //* Enhance Readability
        "no-mixed-spaces-and-tabs": "warn",
        "space-before-blocks": "error",
        "space-in-parens": "error",
        "space-infix-ops": "error",
        "space-unary-ops": "error",
        //
        "keyword-spacing": "error",
        "no-mixed-operators": "error",
        //
        "no-multiple-empty-lines": ["error", { max: 2, maxEOF: 1 }],
        "no-whitespace-before-property": "error",
        "object-property-newline": ["error", { allowAllPropertiesOnSameLine: true }],

        //* ES6
        "arrow-spacing": "error",
        "no-confusing-arrow": "error",
        "no-duplicate-imports": "error",
        "no-var": "error",
        "object-shorthand": "off",
        "prefer-const": "error",
        "prefer-template": "warn",

        camelcase: "off",
        "import/extensions": [
            "warn",
            "ignorePackages",
            {
                js: "never",
                jsx: "never",
            },
        ],
        "import/no-dynamic-require": 0,
        // "global-require": 0,
        "import/prefer-default-export": 0,
        "no-underscore-dangle": 0,
        "no-await-in-loop": 0,
        "no-restricted-syntax": 0,
        "no-return-await": 0,
        "no-console": 0,
        "no-plusplus": 0,
        "no-nested-ternary": 0,
        "no-multi-str": 0,
        "no-useless-catch": 0,
        "no-use-before-define": 0,
        "valid-typeof": 0,
        "new-cap": 0,
        "no-case-declarations": 0,
    },
};
