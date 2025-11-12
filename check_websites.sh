#!/bin/bash

# Файл для логів
logfile="website_status.log"

# Масив сайтів для перевірки
websites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
  "http://example.com"
  "https://x.com"
  "https://githubhoho.com"
)

# Очищаємо лог перед новим запуском
> "$logfile"

# Функція для перевірки статусу сайту
# check_site() {
#   if curl -sL --head "$1" | grep "200" > /dev/null; then
#     echo "$1 is UP" >> "$logfile"
#     echo "$1 is UP" | tee -a "$logfile"
#   else
#     echo "$1 is DOWN"
#     echo "$1 is DOWN" >> "$logfile"
#   fi
# }

# Функція для перевірки статусу сайту
check_site() {
  local site="$1"
  # -L — переходити за редиректами
  status_code=$(curl -L -s -o /dev/null -w "%{http_code}" "$site")

  if [ "$status_code" -eq 200 ]; then
    echo "$site is UP" | tee -a "$logfile"
  else
    echo "$site is DOWN (status: $status_code)" | tee -a "$logfile"
  fi
}



# Основний цикл перевірки
for site in "${websites[@]}"; do
  check_site "$site"
done

# Повідомлення після завершення
echo "Результати записано у файл: $logfile"
