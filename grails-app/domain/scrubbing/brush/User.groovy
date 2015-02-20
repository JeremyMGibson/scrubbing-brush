package scrubbing.brush

class User {
	enum Role {
		VIEW, RUN, EDIT, ADMIN
	}
	
	String email
	String password
	String passwordSalt
	Role role
	
    static constraints = {
		email blank: false
		password blank: false
		role blank: false	
    }
}
