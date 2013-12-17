package com.siyen

class UserRoleController {

  def permisos() {
    User user = User.get(params.id)
    [user:user]
  }

  def save() {
    if(params.authorities) {
      User user = User.get(params.userId)

      def authoritiesIds = []
      authoritiesIds.addAll(params.authorities ?: [])
      authoritiesIds = authoritiesIds.sort()*.toLong()

      def roles = Role.getAll(authoritiesIds)

      roles.each { role ->
        UserRole.create(user, role)
      }
    }

    redirect controller: 'user'
  }

}
