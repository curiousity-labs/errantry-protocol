import chalk from "chalk";

export default class EpicLogger {


  logBot(message: string) {
    console.log(chalk.magenta('[Epic4Bot]'), chalk.magentaBright.italic(message))
  }

  logSystem(message: string) {
    console.log(chalk.blue('[system]'), chalk.bgBlack.bold.gray(message))
  }

  logError(message: string) {
    console.log(chalk.bgBlack.red(message))
  }
}