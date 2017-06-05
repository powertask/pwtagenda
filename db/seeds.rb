# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


unit = Unit.create!(  name: 'Clinica Demonstração e Teste Ltda',
                      cnpj: '05948778000140'  )

user = User.create!(  email: 'marcelo@powertask.com.br', 
                      password: 'galotito', 
                      password_confirmation: 'galotito', 
                      name: 'Marcelo Reichert', 
                      profile: 0,
                      unit_id: unit.id)

user = User.create!(  email: 'luciano@powertask.com.br', 
                      password: 'galotito', 
                      password_confirmation: 'galotito', 
                      name: 'Luciano Monaco', 
                      profile: 0,
                      unit_id: unit.id)

user = User.create!(  email: 'demonstracao@powertask.com.br', 
                      password: 'demonstracao123', 
                      password_confirmation: 'demonstracao123', 
                      name: 'Usuário Demonstração', 
                      profile: 0,
                      unit_id: unit.id)

doctor2 = Doctor.create!( unit_id: unit.id, 
                          name: 'Dr. John Doe',
                          phone: '234456675',
                          email: 'john_doe@test.com',
                          treatment: 'Dr.')

doctor3 = Doctor.create!( unit_id: unit.id, 
                          name: 'Dr. Lorem Ypsum',
                          phone: '234456675',
                          email: 'lorem@test.com',
                          treatment: 'Dr.')


hi1 = HealthInsurance.create!( unit_id: unit.id,
                              name: 'Particular')
hi2 = HealthInsurance.create!( unit_id: unit.id,
                              name: 'Unimed')
hi3 = HealthInsurance.create!( unit_id: unit.id,
                              name: 'Caixa')

room1 = Room.create!( unit_id: unit.id,
                      name: 'Sala de Atendimento 01')
room2 = Room.create!( unit_id: unit.id,
                      name: 'Sala de Atendimento 02')

patient1 = Patient.create!(  unit_id: unit.id,
                            name: 'Eduardo Basanez Reichert',
                            health_insurance_id: hi1.id,
                            birthday: Date.new(2005,4,7),
                            gender: 'M',
                            phone: '9234423',
                            sms: '345345345',
                            email: 'eduardo@test.com'  )

patient2 = Patient.create!(  unit_id: unit.id,
                            name: 'Beatriz Basanez Reichert',
                            health_insurance_id: hi1.id,
                            birthday: Date.new(2007,1,23),
                            gender: 'F',
                            phone: '9234423',
                            sms: '345345345',
                            email: 'eduardo@test.com'  )

patient3 = Patient.create!(  unit_id: unit.id,
                            name: 'Marcelo Reichert',
                            health_insurance_id: hi1.id,
                            birthday: Date.new(1972,3,15),
                            gender: 'M',
                            phone: '9234423',
                            sms: '345345345',
                            email: 'marcelo@test.com'  )

agenda1 = Agenda.create!(  unit_id: unit.id,
                          doctor_id: doctor1.id,
                          room_id: room1.id,
                          agenda_date: Date.new(2017,6,1),
                          start_at: Time.new(2017,6,1,8,0,0),
                          end_at: Time.new(2017,6,1,12,0,0),
                          interval: 60
                        )

agenda_item = AgendaItem.create!( unit_id: unit.id,
                                  agenda_id: agenda1.id,
                                  status: :empty,
                                  scheduled_to: Time.new(2017,12,1,8,0,0)
                                )
agenda_item = AgendaItem.create!( unit_id: unit.id,
                                  agenda_id: agenda1.id,
                                  status: :empty,
                                  scheduled_to: Time.new(2017,12,1,9,0,0)
                                )
agenda_item = AgendaItem.create!( unit_id: unit.id,
                                  agenda_id: agenda1.id,
                                  status: :empty,
                                  scheduled_to: Time.new(2017,12,1,10,0,0)
                                )
agenda_item = AgendaItem.create!( unit_id: unit.id,
                                  agenda_id: agenda1.id,
                                  status: :empty,
                                  scheduled_to: Time.new(2017,12,1,11,0,0)
                                )
agenda_item = AgendaItem.create!( unit_id: unit.id,
                                  agenda_id: agenda1.id,
                                  status: :empty,
                                  scheduled_to: Time.new(2017,12,1,12,0,0)
                                )
