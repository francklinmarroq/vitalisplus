
  create table "public"."laboratories" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "name" character varying(255) not null,
    "address" character varying(255),
    "email" character varying(255),
    "phone_number" character varying(8),
    "owner_id" uuid not null
      );



  create table "public"."parameter_types" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid not null,
    "name" character varying(50) not null
      );



  create table "public"."parameters" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid not null,
    "value_type_id" uuid,
    "low_expected_value" numeric,
    "high_expected_value" numeric,
    "reference_text" character varying(20),
    "unit_id" uuid,
    "parameter_type_id" uuid
      );



  create table "public"."roles" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid not null,
    "name" character varying(30) not null
      );



  create table "public"."tax_info" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid,
    "end_authorized_range" integer,
    "current_voice_number" integer default 0,
    "establishment_point" character varying(3),
    "emission_point" character varying(3),
    "document_type" character varying(3)
      );



  create table "public"."units" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid not null,
    "unit" character varying(10) not null
      );



  create table "public"."user_profiles" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "user_id" uuid not null,
    "laboratory_id" uuid not null,
    "name" character varying(100) not null,
    "phone" character varying(8) not null,
    "role_id" uuid
      );



  create table "public"."value_types" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid not null,
    "name" character varying(50) not null
      );


CREATE UNIQUE INDEX laboratories_pkey ON public.laboratories USING btree (id);

CREATE UNIQUE INDEX parameter_types_pkey ON public.parameter_types USING btree (id);

CREATE UNIQUE INDEX parameters_pkey ON public.parameters USING btree (id);

CREATE UNIQUE INDEX roles_pkey ON public.roles USING btree (id);

CREATE UNIQUE INDEX tax_info_pkey ON public.tax_info USING btree (id);

CREATE UNIQUE INDEX units_pkey ON public.units USING btree (id);

CREATE UNIQUE INDEX user_profiles_pkey ON public.user_profiles USING btree (id);

CREATE UNIQUE INDEX value_types_pkey ON public.value_types USING btree (id);

alter table "public"."laboratories" add constraint "laboratories_pkey" PRIMARY KEY using index "laboratories_pkey";

alter table "public"."parameter_types" add constraint "parameter_types_pkey" PRIMARY KEY using index "parameter_types_pkey";

alter table "public"."parameters" add constraint "parameters_pkey" PRIMARY KEY using index "parameters_pkey";

alter table "public"."roles" add constraint "roles_pkey" PRIMARY KEY using index "roles_pkey";

alter table "public"."tax_info" add constraint "tax_info_pkey" PRIMARY KEY using index "tax_info_pkey";

alter table "public"."units" add constraint "units_pkey" PRIMARY KEY using index "units_pkey";

alter table "public"."user_profiles" add constraint "user_profiles_pkey" PRIMARY KEY using index "user_profiles_pkey";

alter table "public"."value_types" add constraint "value_types_pkey" PRIMARY KEY using index "value_types_pkey";

alter table "public"."laboratories" add constraint "laboratories_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES auth.users(id) not valid;

alter table "public"."laboratories" validate constraint "laboratories_owner_id_fkey";

alter table "public"."parameter_types" add constraint "parameter_types_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."parameter_types" validate constraint "parameter_types_laboratory_id_fkey";

alter table "public"."parameters" add constraint "parameters_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."parameters" validate constraint "parameters_laboratory_id_fkey";

alter table "public"."parameters" add constraint "parameters_parameter_type_id_fkey" FOREIGN KEY (parameter_type_id) REFERENCES public.parameter_types(id) not valid;

alter table "public"."parameters" validate constraint "parameters_parameter_type_id_fkey";

alter table "public"."parameters" add constraint "parameters_unit_id_fkey" FOREIGN KEY (unit_id) REFERENCES public.units(id) not valid;

alter table "public"."parameters" validate constraint "parameters_unit_id_fkey";

alter table "public"."parameters" add constraint "parameters_value_type_id_fkey" FOREIGN KEY (value_type_id) REFERENCES public.value_types(id) not valid;

alter table "public"."parameters" validate constraint "parameters_value_type_id_fkey";

alter table "public"."roles" add constraint "roles_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."roles" validate constraint "roles_laboratory_id_fkey";

alter table "public"."tax_info" add constraint "tax_info_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."tax_info" validate constraint "tax_info_laboratory_id_fkey";

alter table "public"."units" add constraint "units_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."units" validate constraint "units_laboratory_id_fkey";

alter table "public"."user_profiles" add constraint "user_profiles_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."user_profiles" validate constraint "user_profiles_laboratory_id_fkey";

alter table "public"."user_profiles" add constraint "user_profiles_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public.roles(id) not valid;

alter table "public"."user_profiles" validate constraint "user_profiles_role_id_fkey";

alter table "public"."user_profiles" add constraint "user_profiles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."user_profiles" validate constraint "user_profiles_user_id_fkey";

alter table "public"."value_types" add constraint "value_types_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."value_types" validate constraint "value_types_laboratory_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user_profile()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_laboratory_id UUID;
BEGIN
  INSERT INTO laboratories(owner_id, name)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'labName'
  )
  RETURNING id INTO v_laboratory_id;

  INSERT INTO user_profiles(user_id, laboratory_id, name, phone )
  VALUES (
    NEW.id,
    v_laboratory_id,
    NEW.raw_user_meta_data->>'name',
    NEW.raw_user_meta_data->>'phone'
  );

  RETURN NEW;
END;
$function$
;

grant delete on table "public"."laboratories" to "anon";

grant insert on table "public"."laboratories" to "anon";

grant references on table "public"."laboratories" to "anon";

grant select on table "public"."laboratories" to "anon";

grant trigger on table "public"."laboratories" to "anon";

grant truncate on table "public"."laboratories" to "anon";

grant update on table "public"."laboratories" to "anon";

grant delete on table "public"."laboratories" to "authenticated";

grant insert on table "public"."laboratories" to "authenticated";

grant references on table "public"."laboratories" to "authenticated";

grant select on table "public"."laboratories" to "authenticated";

grant trigger on table "public"."laboratories" to "authenticated";

grant truncate on table "public"."laboratories" to "authenticated";

grant update on table "public"."laboratories" to "authenticated";

grant delete on table "public"."laboratories" to "service_role";

grant insert on table "public"."laboratories" to "service_role";

grant references on table "public"."laboratories" to "service_role";

grant select on table "public"."laboratories" to "service_role";

grant trigger on table "public"."laboratories" to "service_role";

grant truncate on table "public"."laboratories" to "service_role";

grant update on table "public"."laboratories" to "service_role";

grant delete on table "public"."parameter_types" to "anon";

grant insert on table "public"."parameter_types" to "anon";

grant references on table "public"."parameter_types" to "anon";

grant select on table "public"."parameter_types" to "anon";

grant trigger on table "public"."parameter_types" to "anon";

grant truncate on table "public"."parameter_types" to "anon";

grant update on table "public"."parameter_types" to "anon";

grant delete on table "public"."parameter_types" to "authenticated";

grant insert on table "public"."parameter_types" to "authenticated";

grant references on table "public"."parameter_types" to "authenticated";

grant select on table "public"."parameter_types" to "authenticated";

grant trigger on table "public"."parameter_types" to "authenticated";

grant truncate on table "public"."parameter_types" to "authenticated";

grant update on table "public"."parameter_types" to "authenticated";

grant delete on table "public"."parameter_types" to "service_role";

grant insert on table "public"."parameter_types" to "service_role";

grant references on table "public"."parameter_types" to "service_role";

grant select on table "public"."parameter_types" to "service_role";

grant trigger on table "public"."parameter_types" to "service_role";

grant truncate on table "public"."parameter_types" to "service_role";

grant update on table "public"."parameter_types" to "service_role";

grant delete on table "public"."parameters" to "anon";

grant insert on table "public"."parameters" to "anon";

grant references on table "public"."parameters" to "anon";

grant select on table "public"."parameters" to "anon";

grant trigger on table "public"."parameters" to "anon";

grant truncate on table "public"."parameters" to "anon";

grant update on table "public"."parameters" to "anon";

grant delete on table "public"."parameters" to "authenticated";

grant insert on table "public"."parameters" to "authenticated";

grant references on table "public"."parameters" to "authenticated";

grant select on table "public"."parameters" to "authenticated";

grant trigger on table "public"."parameters" to "authenticated";

grant truncate on table "public"."parameters" to "authenticated";

grant update on table "public"."parameters" to "authenticated";

grant delete on table "public"."parameters" to "service_role";

grant insert on table "public"."parameters" to "service_role";

grant references on table "public"."parameters" to "service_role";

grant select on table "public"."parameters" to "service_role";

grant trigger on table "public"."parameters" to "service_role";

grant truncate on table "public"."parameters" to "service_role";

grant update on table "public"."parameters" to "service_role";

grant delete on table "public"."roles" to "anon";

grant insert on table "public"."roles" to "anon";

grant references on table "public"."roles" to "anon";

grant select on table "public"."roles" to "anon";

grant trigger on table "public"."roles" to "anon";

grant truncate on table "public"."roles" to "anon";

grant update on table "public"."roles" to "anon";

grant delete on table "public"."roles" to "authenticated";

grant insert on table "public"."roles" to "authenticated";

grant references on table "public"."roles" to "authenticated";

grant select on table "public"."roles" to "authenticated";

grant trigger on table "public"."roles" to "authenticated";

grant truncate on table "public"."roles" to "authenticated";

grant update on table "public"."roles" to "authenticated";

grant delete on table "public"."roles" to "service_role";

grant insert on table "public"."roles" to "service_role";

grant references on table "public"."roles" to "service_role";

grant select on table "public"."roles" to "service_role";

grant trigger on table "public"."roles" to "service_role";

grant truncate on table "public"."roles" to "service_role";

grant update on table "public"."roles" to "service_role";

grant delete on table "public"."tax_info" to "anon";

grant insert on table "public"."tax_info" to "anon";

grant references on table "public"."tax_info" to "anon";

grant select on table "public"."tax_info" to "anon";

grant trigger on table "public"."tax_info" to "anon";

grant truncate on table "public"."tax_info" to "anon";

grant update on table "public"."tax_info" to "anon";

grant delete on table "public"."tax_info" to "authenticated";

grant insert on table "public"."tax_info" to "authenticated";

grant references on table "public"."tax_info" to "authenticated";

grant select on table "public"."tax_info" to "authenticated";

grant trigger on table "public"."tax_info" to "authenticated";

grant truncate on table "public"."tax_info" to "authenticated";

grant update on table "public"."tax_info" to "authenticated";

grant delete on table "public"."tax_info" to "service_role";

grant insert on table "public"."tax_info" to "service_role";

grant references on table "public"."tax_info" to "service_role";

grant select on table "public"."tax_info" to "service_role";

grant trigger on table "public"."tax_info" to "service_role";

grant truncate on table "public"."tax_info" to "service_role";

grant update on table "public"."tax_info" to "service_role";

grant delete on table "public"."units" to "anon";

grant insert on table "public"."units" to "anon";

grant references on table "public"."units" to "anon";

grant select on table "public"."units" to "anon";

grant trigger on table "public"."units" to "anon";

grant truncate on table "public"."units" to "anon";

grant update on table "public"."units" to "anon";

grant delete on table "public"."units" to "authenticated";

grant insert on table "public"."units" to "authenticated";

grant references on table "public"."units" to "authenticated";

grant select on table "public"."units" to "authenticated";

grant trigger on table "public"."units" to "authenticated";

grant truncate on table "public"."units" to "authenticated";

grant update on table "public"."units" to "authenticated";

grant delete on table "public"."units" to "service_role";

grant insert on table "public"."units" to "service_role";

grant references on table "public"."units" to "service_role";

grant select on table "public"."units" to "service_role";

grant trigger on table "public"."units" to "service_role";

grant truncate on table "public"."units" to "service_role";

grant update on table "public"."units" to "service_role";

grant delete on table "public"."user_profiles" to "anon";

grant insert on table "public"."user_profiles" to "anon";

grant references on table "public"."user_profiles" to "anon";

grant select on table "public"."user_profiles" to "anon";

grant trigger on table "public"."user_profiles" to "anon";

grant truncate on table "public"."user_profiles" to "anon";

grant update on table "public"."user_profiles" to "anon";

grant delete on table "public"."user_profiles" to "authenticated";

grant insert on table "public"."user_profiles" to "authenticated";

grant references on table "public"."user_profiles" to "authenticated";

grant select on table "public"."user_profiles" to "authenticated";

grant trigger on table "public"."user_profiles" to "authenticated";

grant truncate on table "public"."user_profiles" to "authenticated";

grant update on table "public"."user_profiles" to "authenticated";

grant delete on table "public"."user_profiles" to "service_role";

grant insert on table "public"."user_profiles" to "service_role";

grant references on table "public"."user_profiles" to "service_role";

grant select on table "public"."user_profiles" to "service_role";

grant trigger on table "public"."user_profiles" to "service_role";

grant truncate on table "public"."user_profiles" to "service_role";

grant update on table "public"."user_profiles" to "service_role";

grant delete on table "public"."value_types" to "anon";

grant insert on table "public"."value_types" to "anon";

grant references on table "public"."value_types" to "anon";

grant select on table "public"."value_types" to "anon";

grant trigger on table "public"."value_types" to "anon";

grant truncate on table "public"."value_types" to "anon";

grant update on table "public"."value_types" to "anon";

grant delete on table "public"."value_types" to "authenticated";

grant insert on table "public"."value_types" to "authenticated";

grant references on table "public"."value_types" to "authenticated";

grant select on table "public"."value_types" to "authenticated";

grant trigger on table "public"."value_types" to "authenticated";

grant truncate on table "public"."value_types" to "authenticated";

grant update on table "public"."value_types" to "authenticated";

grant delete on table "public"."value_types" to "service_role";

grant insert on table "public"."value_types" to "service_role";

grant references on table "public"."value_types" to "service_role";

grant select on table "public"."value_types" to "service_role";

grant trigger on table "public"."value_types" to "service_role";

grant truncate on table "public"."value_types" to "service_role";

grant update on table "public"."value_types" to "service_role";

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_profile();


