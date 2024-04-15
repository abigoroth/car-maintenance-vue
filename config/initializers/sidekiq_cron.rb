# cron: '0 8 * * *',
Sidekiq::Cron::Job.create(
  name: 'Notification job - Daily',
  cron: '0 8 * * * Asia/Kuala_Lumpur',
  class: 'NotificationJob'
)
