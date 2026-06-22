Application.put_env(:junit_formatter, :report_dir, "test/reports")
Application.put_env(:junit_formatter, :report_file, "junit.xml")
Application.put_env(:junit_formatter, :automatic_create_dir?, true)

ExUnit.start(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
