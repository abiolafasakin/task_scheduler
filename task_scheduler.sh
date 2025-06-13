#!/bin/bash

# Function to display the scheduled tasks
list_tasks() {
  echo "Scheduled tasks:"
  crontab -l
  echo
}

# Function to add a new task
add_task() {
  read -p "Enter the command or script to be executed: " command
  read -p "Enter the schedule ('hourly', 'daily', 'weekly'): " schedule
  read -p "Enter any additional parameters: " parameters

  #Based on the user's input for the schedule, the function assigns a 
  #corresponding cron expression
  case $schedule in
    hourly)
      cron_schedule="0 * * * *"
      ;;
    daily)
      cron_schedule="0 0 * * *"
      ;;
    weekly)
      cron_schedule="0 0 * * 0"
      ;;
    *)
      echo "Invalid schedule. Please enter 'hourly', 'daily', or 'weekly'."
      return
      ;;
  esac

  # Add the task to the crontab
  (
    crontab -l 2> /dev/null
    echo "$cron_schedule $command $parameters"
  ) | crontab -

  echo "Task scheduled successfully."
  echo
}