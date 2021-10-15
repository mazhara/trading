package trading.lib

import cats.effect.std.Console

trait Logger[F[_]]:
  def info(str: => String): F[Unit]
  def error(str: => String): F[Unit]
  def warn(str: => String): F[Unit]

object Logger:
  def apply[F[_]: Logger]: Logger[F] = summon

  given forConsole[F[_]](using C: Console[F]): Logger[F] with
    def info(str: => String): F[Unit]  = C.println(s"[info] - $str")
    def error(str: => String): F[Unit] = C.errorln(s"[error] - $str")
    def warn(str: => String): F[Unit]  = C.println(s"[warn] - $str")
