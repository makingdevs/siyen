import com.siyen.UserPasswordEncoderListener
// Place your Spring DSL code here
beans = {
  userPasswordEncoderListener(UserPasswordEncoderListener, ref('hibernateDatastore'))

  vertx(io.vertx.core.Vertx) { bean ->
    bean.factoryMethod = "vertx"
  }
}
