ActiveRecord::Base.configurations[:test] = {
  adapter: 'postgresql',
  database: 'downthemall_test',
  username: 'postgres',
  password: '',
  host: '127.0.0.1',
  port: 5432
}

