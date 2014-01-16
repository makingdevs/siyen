package com.siyen.exceptions

import org.springframework.core.NestedRuntimeException

class BusinessException extends NestedRuntimeException {

  Object data

  BusinessException(String msg, Object data) {
    super(msg)
    this.data = data
  }

}
