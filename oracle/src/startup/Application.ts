import EpicLogger from "../utils/Logger"
import corsOptions from "cors"
import express from "express"
import http from "http"
import morgan from "morgan"
import config from "../../config"

export default class Application {
  public core: express.Application
  logger = new EpicLogger()
  constructor() {
    this.core = express()
    this.cors()
    this.logging()
    this.encoding()

    this.initilizeServer()
  }

  private cors() {
    this.core.use(corsOptions())
  }
  private logging() {
    this.core.use(morgan("dev"))
  }
  private encoding() {
    this.core.use(express.json())
    this.core.use(express.urlencoded({ extended: true }))
  }

  private normalizePort(val: string) {
    const port = parseInt(val, 10)
    if (isNaN(port)) return val
    if (port >= 0) return port
    return false
  }
  private onError(error: any) {
    if (error.syscall !== "listen") {
      throw error.message
    }
    const bind = typeof config.port === "string" ? "Pipe " + config.port : "Port " + config.port
    // handle specific listen errors with friendly messages
    switch (error.code) {
      case "EACCES":
        console.error(bind + " requires elevated privileges")
        process.exit(1)
      case "EADDRINUSE":
        console.error(bind + " is already in use")
        process.exit(1)
      default:
        throw error
    }
  }

  initilizeServer() {
    const server = http.createServer(this.core)
    const port = this.normalizePort(config.port)

    this.core.set("port", port)

    server.listen(port)
    console.log("🚀 ~ config:", config)

    server.on("error", this.onError)
    server.on("listening", () => {
      this.logger.logSystem(`is listening on ${config.port}.`)
    })
  }
}
