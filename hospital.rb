class Hospital
	attr_accessor :name
	attr_accessor :location
	attr_accessor :patients
	attr_accessor :employees

	def initialize(name,location)
		@name = name
		@location = location
		@patients = Hash.new
		@employees = Hash.new
		@doctor_login = false
		@login = false
		@password_passed = false
		@logout = false
	end

	def add_patient(name,age)
		@patients[name] = Patient.new(name,age)
	end

	def add_employee(name,password,type)
		@employees[name] = Employee.new(name,password,type)
	end

	def delete_patient(name)
		@patients.delete(name)
	end

	def delete_employee(name)
		@employees.delete(name)
	end

	def run_console
		#Reset logins
		@doctor_login = false
		@login = false
		@password_passed = false
		
		#Welcome and identify
		puts "Hello. Welcome to #{name} Administration System. Please identify yourself:"
		while @login == false
			user = gets.chomp
			if user == "EXIT"
				break
			elsif @employees.has_key?(user)
				@login = true
				puts "User found..."
				puts "Hello #{user}"
			else
				puts "Error: username #{user} doesn't exist. Please try again."
				puts "Please identify yourself:"
			end
		end

		#Test password and determine if Doctor
		if @login == true
			puts "Please authenticate with your password:"
			while @password_passed == false
				password = gets.chomp
				if password == "EXIT"
					break
				elsif @employees[user].password == password
					@password_passed = true
					@doctor_login = true if @employees[user].type == "Doctor"
					puts "Authentication successful!"
				else
					puts "Error: password '#{password}' incorrect. Please try again."
					puts "Please authenticate with your password:"
				end
			end
		end	

		#Introduce control panel, print out access level
		puts "Your access level is #{@employees[user].type}"
		puts "Your available functions are listed below. It may be blank if you don't have high enough access level for any functions."

		#Read and respond to actions
		while @logout == false			
			puts "Options:"
			puts "-  list_patients" if @doctor_login == true
			puts "-  view_records <patient_name>" if @doctor_login == true
			puts "-  add_record <patient_name> (you will be prompted for the record content)" if @doctor_login == true
			puts "-  remove_record <patient_name> (you will be prompted for the record ID to remove)" if @doctor_login == true
			puts "-  logout"
			action = gets.chomp
			#list_patients
			puts @patients.keys if action == "list_patients"
			#view_records
			puts @patients[action.split[1]].records if action.split[0] == "view_records"
			#add_record
			if action.split[0] == "add_record"
				puts "Adding record for #{action.split[1]}. Please type the record below:"
				temp = gets.chomp
				@patients[action.split[1]].add_record(temp)
			end
			#remove_record
			if action.split[0] == "remove_record"
				puts "Removing record for #{action.split[1]}."
				puts "These are the current records on file:"
				@patients[action.split[1]].records.each_index { |i|
					puts "#{i}: #{@patients[action.split[1]].records[i]}"
				}
				puts "Please choose record to delete:"
				temp = gets.chomp
				@patients[action.split[1]].delete_record(temp)
			end
			#logout
			@logout = true if action == "logout"
		end
		@logout = false

	end
end

class Patient
	attr_accessor :name
	attr_accessor :age
	attr_accessor :records
	

	def initialize(name,age)
		@name = name
		@age = age
		@records = Array.new
	end

	def add_record(record)
		puts "Adding record: \n#{record.to_s} \n..."
		@records[@records.length] = record.to_s
		puts "...Record added as record ID #{@records.length-1}"
		puts "Record ID #{@records.length-1} : #{@records[@records.length-1]}"
		puts "Record ID #{@records.length-1} : #{@records.last}"
	end

	def delete_record(id)
		puts "Deleting record #{id}: #{@records[id.to_i]}"
		puts "..."
		@records.delete_at(id.to_i)
		puts "...Delete successful!" 
		puts "Records are now:"
		@records.each_index { |i|
			puts "#{i}: #{@records[i]}"
		}
	end

end

class Employee
	attr_accessor :name
	attr_accessor :type
	attr_accessor :password

	def initialize(name,password,type)
		@name = name
		@password = password
		@type = type
	end
end


box_hill = Hospital.new('Box Hill Hospital', '123 Fake St, Box Hill, Victoria, Australia')
box_hill.add_employee("Zezan","pass","Doctor")
box_hill.add_patient("Jane",25)
box_hill.patients["Jane"].add_record("Hello!")
box_hill.patients["Jane"].add_record("Record 2")
box_hill.patients["Jane"].add_record("This is cool")
box_hill.run_console



