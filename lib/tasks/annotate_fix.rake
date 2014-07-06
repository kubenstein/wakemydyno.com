# Annotate models
task :annotate do
  puts 'Annotating models...'
  system 'bundle exec annotate'
end

# Run annotate task after db:migrate
#  and db:rollback tasks
Rake::Task['db:migrate'].enhance do
  Rake::Task['annotate'].invoke
end