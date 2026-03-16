
  create table "public"."units" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "laboratory_id" uuid,
    "unit" character varying(10) not null
      );


CREATE UNIQUE INDEX units_pkey ON public.units USING btree (id);

alter table "public"."units" add constraint "units_pkey" PRIMARY KEY using index "units_pkey";

alter table "public"."units" add constraint "units_laboratory_id_fkey" FOREIGN KEY (laboratory_id) REFERENCES public.laboratories(id) not valid;

alter table "public"."units" validate constraint "units_laboratory_id_fkey";

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


