MaintenanceRecord.delete_all
Equipment.delete_all
Category.delete_all

computing   = Category.create!(name: "Computing")
optics      = Category.create!(name: "Optics")
networking  = Category.create!(name: "Networking")
electronics = Category.create!(name: "Electronics")

laptop     = Equipment.create!(name: "Dell Laptop",         serial_number: "LAP-001", status: "available",   category: computing)
raspberry  = Equipment.create!(name: "Raspberry Pi 4",      serial_number: "RPI-002", status: "in_use",      category: computing)
microscope = Equipment.create!(name: "Lab Microscope",      serial_number: "MIC-003", status: "maintenance", category: optics)
zoom_lens  = Equipment.create!(name: "Zoom Lens 40x",       serial_number: "LNS-004", status: "available",   category: optics)
router     = Equipment.create!(name: "Cisco Router",        serial_number: "RTR-005", status: "available",   category: networking)
switch     = Equipment.create!(name: "Network Switch",      serial_number: "SWT-006", status: "maintenance", category: networking)
arduino    = Equipment.create!(name: "Arduino Starter Kit", serial_number: "ARD-007", status: "in_use",      category: electronics)
breadboard = Equipment.create!(name: "Breadboard Kit",      serial_number: "BRD-008", status: "in_use",      category: electronics)

MaintenanceRecord.create!(
  description:  "Replaced thermal paste and cleaned the cooling fan. Unit was throttling under sustained load.",
  performed_at: 3.weeks.ago,
  equipment:    laptop
)

MaintenanceRecord.create!(
  description:  "Updated BIOS firmware and ran a full disk diagnostic scan. No bad sectors detected.",
  performed_at: 1.week.ago,
  equipment:    laptop
)

MaintenanceRecord.create!(
  description:  "Cleaned all objective lenses and recalibrated the focus mechanism after reported image distortion.",
  performed_at: 2.months.ago,
  equipment:    microscope
)

MaintenanceRecord.create!(
  description:  "Replaced cracked eyepiece and confirmed magnification accuracy across all zoom levels.",
  performed_at: 3.days.ago,
  equipment:    microscope
)

MaintenanceRecord.create!(
  description:  "Reset device to factory defaults and applied the latest vendor firmware patch.",
  performed_at: 10.days.ago,
  equipment:    router
)

puts ""
puts "Seed complete:"
puts "  Categories:          #{Category.count}"
puts "  Equipment:           #{Equipment.count}"
puts "  Maintenance records: #{MaintenanceRecord.count}"
