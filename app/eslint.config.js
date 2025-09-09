module.exports = [
  {
    files: ["**/*.js"],
    ignores: ["node_modules/**", "dist/**", "eslint.config.js"],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: "commonjs",
      globals: {
        console: true,
        require: true,
        module: true,
        process: true   // <<<<<< AQUI
      }
    },
    rules: {
      "no-unused-vars": "warn",
      "no-undef": "error"
    }
  },
  {
    files: ["**/__tests__/**/*.js", "**/*.test.js"],
    languageOptions: {
      globals: {
        test: true,
        expect: true,
        describe: true,
        beforeAll: true,
        beforeEach: true,
        afterAll: true,
        afterEach: true
      }
    }
  }
];
