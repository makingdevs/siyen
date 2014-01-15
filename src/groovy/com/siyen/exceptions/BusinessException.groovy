package com.siyen.exceptions

import org.springframework.core.NestedRuntimeException

class BusinessException extends NestedRuntimeException {

  String message
  def data

  BusinessException(String msg) {
    super(msg)
  }

  BusinessException(String msg, Throwable cause) {
    super(msg, cause)
  }

  BusinessException(String msg, def data) {
    this.message = msg
    this.data = data
  }

}
