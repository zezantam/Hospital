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
	end

	def update_patients(file)
		puts "Erasing current patients database..."
		@patients.clear
		puts "...patients database cleared." if @patients.length == 0
		puts "Loading new patients..."
		require 'csv'
		count = 0
		CSV.foreach(file) do |row|
			puts row[2]
			values = {'age'=>row[1],'records'=>row[2]}
#How do I get the string recognised as a Hash?			
			patients[row[0]] =	values
			count += 1
		end
		puts "...Patients updated. #{count} patients added." if count == @patients.length
		puts "...something went wrong" if count != @patients.length
	end

	def update_employees(file)
		puts "Erasing current employees database..."
		@employees.clear
		puts "...employees database cleared." if @employees.length == 0
		puts "Loading new employees..."
		require 'csv'
		count = 0
		CSV.foreach(file) do |row|
			@employees[row[0]] = row[1]
			count += 1
		end
		puts "...Employees updated. #{count} employees added." if count == @employees.length
		puts "...something went wrong" if count != @employees.length
	end

	def update
		self.update_patients('patients.txt')
		self.update_employees('employees.txt')
	end

	def add_patient(name,age,records)
		@patients[patient] = {"age"=>age,"records"=>records}

	end

	def add_employee(name,type)
		@employees[name] = type
		require 'csv'
   		CSV.open('employees.txt', "wb") do |csv|
      		@employees.each {|a|
        		csv << a
     		}
    	end
	end
end

class Patient
	attr_accessor :name
	attr_accessor :age
	attr_accessor :records
	

	def initialize(name,age)
		@name = name
		@age = age
		@records = Hash.new
	end

	def add_record(record)
		puts "Adding record: \n#{record.to_s} \n..."
		@records[@records.keys.sort.last] = record.to_s
		puts "...Record added as record ID #{@records.key(record)}"
		puts "...something went wrong" if @records.key(record) == nil
	end

	def delete_record(id)
		puts "Deleting record #{id}: #{@records[id]}"
		puts "..."
		@records.delete(id)
		puts "...Delete successful!" if @records.has_key?(id) == false
		puts "...something went wrong" if @records.has_key?(id) == true
	end

end

class Employee
	attr_accessor :name
	attr_accessor :type

	def initialize(name,type)
		@name = name
		@type = type
	end
end


box_hill = Hospital.new('Box Hill Hospital', '123 Fake St, Box Hill, Victoria, Australia')
box_hill.update
puts box_hill.patients.inspect
puts box_hill.employees.inspect
box_hill.add_employee(Dr Suresh Mohammed,Doctor)





