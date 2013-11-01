class Hospital(name,location)
	attr_accessor :name
	attr_accessor :location
	attr_accessor :patients
	attr_accessor :employees


	def initialize
		@name = name
		@location = location
		@patients = []
		@employees = []
	end

	def update_patients(file)
		puts "Erasing current patients database..."
		@patients.clear
		puts "...patients database cleared." if @patients.length == 0
		puts "Loading new patients..."
		require 'csv'
		count = 0
		CSV.foreach(file) do |row|
			@patients << row
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
			@employees << row
			count += 1
		end
		puts "...Employees updated. #{count} employees added." if count == @employees.length
		puts "...something went wrong" if count != @employees.length
	end

	def update(patients_file,employees_file)
		self.update_patients(patients_file)
		self.update_employees(employees_file)
	end
end

class Patient
