package com.siyen

class UserRoleController {

  def permisos() {
    User user = User.get(params.id)
    [user:user]
  }

  def save() {
    if(params.authorities) {
      User user = User.get(params.id)

      def authoritiesIds = []
      authoritiesIds.addAll(params.authorities ?: [])
      authoritiesIds = authoritiesIds.sort()*.toLong()

      def roles = Role.getAll(authoritiesIds)

      UserRole.removeAll(user)

      roles.each { role ->
        UserRole.create(user, role, true)
      }
    }

    redirect controller: 'user'
  }

}
