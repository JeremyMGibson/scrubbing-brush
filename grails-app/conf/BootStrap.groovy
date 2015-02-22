import chia.Role
import chia.User
import chia.UserRole

class BootStrap {

    def init = { servletContext ->
      def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
	  def editorRole = new Role(authority: 'ROLE_EDITOR').save(flush: true)
      def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

      def testUser = new User(username: 'me', password: 'password')
      testUser.save(flush: true)

      UserRole.create testUser, adminRole, true
	  UserRole.create testUser, editorRole, true

      assert User.count() == 1
      assert Role.count() == 3
      assert UserRole.count() == 2
   }
    def destroy = {
    }
}
