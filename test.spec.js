import { fez } from "fez-lisp";
import { readFileSync, readdirSync } from "fs";
const logError = (error) => console.log("\x1b[31m", `\n${error}\n`, "\x1b[0m");
const logSuccess = (output) => console.log('\x1b[32m', output, "\x1b[0m");
const isEqual = (a, b) =>
  (Array.isArray(a) &&
    a.length === b.length &&
    !a.some((_, i) => !isEqual(a.at(i), b.at(i)))) ||
  a === b ||
  0;
const map = [
  { file: "day1.lisp", result: [11, 31] },
  { file: "day10.lisp", result: [36, 81] },
  { file: "day11.lisp", result: [13, 55312] },
  { file: "day13.lisp", result: [480, 875318608908] },
  { file: "day14.lisp", result: [12] },
  { file: "day16.lisp", result: [0] },
  { file: "day17.lisp", result: [[4, 6, 3, 5, 6, 3, 5, 2, 1, 0]] },
  { file: "day18.lisp", result: [22] },
  { file: "day19.lisp", result: [6, 16] },
  { file: "day2.lisp", result: [2, 4] },
  { file: "day22.lisp", result: [37327623] },
  { file: "day23.lisp", result: [7] },
  { file: "day3.lisp", result: [161, 48] },
  { file: "day4.lisp", result: [18, 9] },
  { file: "day5.lisp", result: [143, 123] },
  { file: "day6.lisp", result: [41, 6] },
  { file: "day7.lisp", result: [3749, 11387] },
  { file: "day8.lisp", result: [14, 34] },
  { file: "day9.lisp", result: [1928] },
].reduce((a, b) => {
  a.set(b.file, b.result);
  return a;
}, new Map());
if (
  readdirSync("./")
    .filter((x) => x.endsWith(".lisp"))
    .every((x) => {
      const a = map.get(x);
      const b = eval(
        fez(readFileSync(x, "utf-8"), {
          mutation: 1,
          compile: 1,
        })
      );
      const assertion = isEqual(a, b);
      if (!assertion) {
        logError(`${x} failed!`);
      }
      return assertion;
    })
)
  logSuccess("All tests passed");
// console.log(
//   readdirSync("./")
//     .filter((x) => x.endsWith(".lisp"))
//     .map((file) => ({
//       file,
//       result: eval(
//         fez(readFileSync(file, "utf-8"), {
//           mutation: 1,
//           compile: 1,
//         })
//       ),
//     }))
// );
