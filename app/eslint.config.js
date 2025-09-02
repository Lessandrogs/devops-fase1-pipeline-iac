export default [
  // Regras padrão (CommonJS + Node)
  {
    files: ["**/*.js"],
    ignores: ["node_modules/**", "dist/**"],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: "commonjs",
      // Booleans (flat config)
      globals: {
        console: true,
        require: true,
        module: true
      }
    },
    rules: {
      "no-unused-vars": "warn",
      "no-undef": "error"
    }
  },
  // Regras para testes (habilita globals do Jest)
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
