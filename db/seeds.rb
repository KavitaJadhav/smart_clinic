doctor = Doctor.create(first_name: 'Priya', last_name: 'Mehata', email: 'priya@mail.com')

for i in 21..30 do
  WorkingDay.create(doctor_id: doctor.id, date: Date.parse("#{i}/09/2023"), from_time: '10:00', to_time: "14:00")
end

patient1 = Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com')
patient2 = Patient.create(first_name: 'Jyoti', last_name: 'Jadhav', email: 'jyoti@mail.com')
patient3 = Patient.create(first_name: 'Ravi', last_name: 'Jadhav', email: 'ravi@mail.com')

Appointment.create(patient: patient1, doctor: doctor, date: Date.parse("21/09/2023"), from_time: '10:00', to_time: '10:15')
Appointment.create(patient: patient1, doctor: doctor, date: Date.parse("21/09/2023"), from_time: '11:00', to_time: '11:15')

Appointment.create(patient: patient2, doctor: doctor, date: Date.parse("23/09/2023"), from_time: '13:00', to_time: '13:15')
Appointment.create(patient: patient2, doctor: doctor, date: Date.parse("23/09/2023"), from_time: '13:15', to_time: '13:30')

Appointment.create(patient: patient3, doctor: doctor, date: Date.parse("25/09/2023"), from_time: '13:30', to_time: '13:45')
Appointment.create(patient: patient3, doctor: doctor, date: Date.parse("25/09/2023"), from_time: '13:45', to_time: '14:00')
