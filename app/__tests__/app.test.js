/* eslint-env jest */
const { sum } = require("../src/index.js");

test("sum adds numbers", () => {
  expect(sum(2, 3)).toBe(5);
});
