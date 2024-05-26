drop view if exists "public"."company_slug";

drop view if exists "public"."industry";

alter table "public"."company" drop column "autogenerated_contact";

alter table "public"."company" drop column "sustainability_contact_email";

alter table "public"."company" drop column "sustainability_contact_linkedin";

alter table "public"."company" drop column "sustainability_contact_name";

create or replace view "public"."company_slug" as  SELECT company.name AS company_name,
    company.industry,
    company.isic,
    company.lei,
    company.company_url,
    company.source_reports_page,
    company.sbt_status,
    company.sbt_near_term_year,
    company.sbt_near_term_target,
    company.net_zero_year,
    regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.name)), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug
   FROM company;


create or replace view "public"."industry" as  SELECT company.industry AS name,
    regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.industry)), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug,
    count(company.name) AS company_count
   FROM company
  GROUP BY company.industry
 HAVING ((company.industry IS NOT NULL) AND (count(company.name) >= 2))
  ORDER BY company.industry;


