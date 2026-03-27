alter table "public"."parameters" drop constraint "parameters_unit_id_fkey";


  create table "public"."reference_ranges" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "test_type_parameter_id" uuid not null,
    "low_value" numeric,
    "high_value" numeric,
    "reference_text" character varying(100),
    "gender" character varying(1),
    "min_age_years" integer,
    "max_age_years" integer
      );



  create table "public"."test_type_parameters" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "test_type_id" uuid not null,
    "parameter_id" uuid not null,
    "unit_id" uuid
      );



  create table "public"."test_types" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid not null,
    "name" character varying(50) not null
      );


alter table "public"."parameters" drop column "high_expected_value";

alter table "public"."parameters" drop column "low_expected_value";

alter table "public"."parameters" drop column "reference_text";

alter table "public"."parameters" drop column "unit_id";

CREATE UNIQUE INDEX reference_ranges_pkey ON public.reference_ranges USING btree (id);

CREATE UNIQUE INDEX test_type_parameters_pkey ON public.test_type_parameters USING btree (id);

CREATE UNIQUE INDEX test_types_pkey ON public.test_types USING btree (id);

alter table "public"."reference_ranges" add constraint "reference_ranges_pkey" PRIMARY KEY using index "reference_ranges_pkey";

alter table "public"."test_type_parameters" add constraint "test_type_parameters_pkey" PRIMARY KEY using index "test_type_parameters_pkey";

alter table "public"."test_types" add constraint "test_types_pkey" PRIMARY KEY using index "test_types_pkey";

alter table "public"."reference_ranges" add constraint "reference_ranges_test_type_parameter_id_fkey" FOREIGN KEY (test_type_parameter_id) REFERENCES public.test_type_parameters(id) not valid;

alter table "public"."reference_ranges" validate constraint "reference_ranges_test_type_parameter_id_fkey";

alter table "public"."test_type_parameters" add constraint "test_type_parameters_parameter_id_fkey" FOREIGN KEY (parameter_id) REFERENCES public.parameters(id) not valid;

alter table "public"."test_type_parameters" validate constraint "test_type_parameters_parameter_id_fkey";

alter table "public"."test_type_parameters" add constraint "test_type_parameters_test_type_id_fkey" FOREIGN KEY (test_type_id) REFERENCES public.test_types(id) not valid;

alter table "public"."test_type_parameters" validate constraint "test_type_parameters_test_type_id_fkey";

alter table "public"."test_type_parameters" add constraint "test_type_parameters_unit_id_fkey" FOREIGN KEY (unit_id) REFERENCES public.units(id) not valid;

alter table "public"."test_type_parameters" validate constraint "test_type_parameters_unit_id_fkey";

alter table "public"."test_types" add constraint "test_types_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."test_types" validate constraint "test_types_laboratory_id_fkey";

grant delete on table "public"."reference_ranges" to "anon";

grant insert on table "public"."reference_ranges" to "anon";

grant references on table "public"."reference_ranges" to "anon";

grant select on table "public"."reference_ranges" to "anon";

grant trigger on table "public"."reference_ranges" to "anon";

grant truncate on table "public"."reference_ranges" to "anon";

grant update on table "public"."reference_ranges" to "anon";

grant delete on table "public"."reference_ranges" to "authenticated";

grant insert on table "public"."reference_ranges" to "authenticated";

grant references on table "public"."reference_ranges" to "authenticated";

grant select on table "public"."reference_ranges" to "authenticated";

grant trigger on table "public"."reference_ranges" to "authenticated";

grant truncate on table "public"."reference_ranges" to "authenticated";

grant update on table "public"."reference_ranges" to "authenticated";

grant delete on table "public"."reference_ranges" to "service_role";

grant insert on table "public"."reference_ranges" to "service_role";

grant references on table "public"."reference_ranges" to "service_role";

grant select on table "public"."reference_ranges" to "service_role";

grant trigger on table "public"."reference_ranges" to "service_role";

grant truncate on table "public"."reference_ranges" to "service_role";

grant update on table "public"."reference_ranges" to "service_role";

grant delete on table "public"."test_type_parameters" to "anon";

grant insert on table "public"."test_type_parameters" to "anon";

grant references on table "public"."test_type_parameters" to "anon";

grant select on table "public"."test_type_parameters" to "anon";

grant trigger on table "public"."test_type_parameters" to "anon";

grant truncate on table "public"."test_type_parameters" to "anon";

grant update on table "public"."test_type_parameters" to "anon";

grant delete on table "public"."test_type_parameters" to "authenticated";

grant insert on table "public"."test_type_parameters" to "authenticated";

grant references on table "public"."test_type_parameters" to "authenticated";

grant select on table "public"."test_type_parameters" to "authenticated";

grant trigger on table "public"."test_type_parameters" to "authenticated";

grant truncate on table "public"."test_type_parameters" to "authenticated";

grant update on table "public"."test_type_parameters" to "authenticated";

grant delete on table "public"."test_type_parameters" to "service_role";

grant insert on table "public"."test_type_parameters" to "service_role";

grant references on table "public"."test_type_parameters" to "service_role";

grant select on table "public"."test_type_parameters" to "service_role";

grant trigger on table "public"."test_type_parameters" to "service_role";

grant truncate on table "public"."test_type_parameters" to "service_role";

grant update on table "public"."test_type_parameters" to "service_role";

grant delete on table "public"."test_types" to "anon";

grant insert on table "public"."test_types" to "anon";

grant references on table "public"."test_types" to "anon";

grant select on table "public"."test_types" to "anon";

grant trigger on table "public"."test_types" to "anon";

grant truncate on table "public"."test_types" to "anon";

grant update on table "public"."test_types" to "anon";

grant delete on table "public"."test_types" to "authenticated";

grant insert on table "public"."test_types" to "authenticated";

grant references on table "public"."test_types" to "authenticated";

grant select on table "public"."test_types" to "authenticated";

grant trigger on table "public"."test_types" to "authenticated";

grant truncate on table "public"."test_types" to "authenticated";

grant update on table "public"."test_types" to "authenticated";

grant delete on table "public"."test_types" to "service_role";

grant insert on table "public"."test_types" to "service_role";

grant references on table "public"."test_types" to "service_role";

grant select on table "public"."test_types" to "service_role";

grant trigger on table "public"."test_types" to "service_role";

grant truncate on table "public"."test_types" to "service_role";

grant update on table "public"."test_types" to "service_role";


