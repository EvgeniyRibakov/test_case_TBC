# test_case_TBC

Тестовое задание: SQL (SQL Server) и BI (Power BI).

## Структура репозитория

| Путь | Назначение |
|------|------------|
| `SQL_solutions/schema_and_data.sql` | Создание таблиц и тестовые данные |
| `SQL_solutions/task1.sql` … `task6.sql` | Решения задач 1–6 |
| `BI_solution/test_tbc.pbix` | Отчёт Power BI |
| `BI_solution/Dataset/` | CSV для модели (dim/fact) |
| `BI_solution/README_rus.docx` / `README_eng.docx` | Описание BI-части (подробно) |

## SQL: как проверить

1. Выполнить `SQL_solutions/schema_and_data.sql`
2. По очереди выполнить `SQL_solutions/task1.sql` … `SQL_solutions/task6.sql`

Скрипты написаны под **Microsoft SQL Server (T-SQL)**. В файлах задач есть короткие комментарии по логике.

## BI (кратко по README из `BI_solution`)

Дашборд **«Эффективность взыскания и анализ просроченного портфеля (Collections & Overdue)»**: синтетический банковский контекст взыскания, **звёздная схема** (dim_customers, dim_collectors, dim_calendar, fact_loans, fact_payments, fact_collection_actions), подготовка данных в **Power Query** (типизация, дедуп, DPD-бакеты, стадии взыскания, PTP и др.), ключевые **DAX**-метрики (Outstanding/Overdue, Recovery, Contact/PTP rate и т.д.), страницы **Executive Overview**, **DPD & Risk**, **Collection Team Performance**, **Operational Loan Details**, параметр **Top N Collectors**, **RLS** по ролям (регион / супервайзеры), базовые шаги по производительности (отключение auto date/time, вынесение тяжёлых таблиц на отдельные страницы и др.).

Подробности — в `BI_solution/README_rus.docx` (или `README_eng.docx`).
