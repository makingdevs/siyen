package com.siyen

import org.springframework.http.HttpMethod

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes=['configAttribute', 'httpMethod', 'url'])
@ToString(includes=['configAttribute', 'httpMethod', 'url'], cache=true, includeNames=true, includePackage=false)
class Requestmap implements Serializable {

  private static final long serialVersionUID = 1

  String url
  String configAttribute

  static mapping = {
    cache true
  }

  static constraints = {
    url blank: false, unique: true
    configAttribute blank: false
  }

  Requestmap() { }

  Requestmap(String url, String configAttribute) {
    this()
    this.configAttribute = configAttribute
    this.url = url
  }
}
