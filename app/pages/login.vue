<script setup lang="ts">
import { useSupabaseClient } from "@supabase/supabase-js";
const supabase = useSupabaseClient();
const username = ref("");
const email = ref("");
async function handleRegistration() {}
</script>

<template>
    <div class="grid justify-center content-center h-dvh">
        <div
            class="h-fit p-3 border border-slate-200 shadow-lg shadow-slate-200 rounded-xl bg-white"
        >
            <div class="text-2xl font-bold">
                <p>Connor anal</p>
                <h3>Registrarse</h3>
            </div>
            <form id="registerFrm" class="">
                <div class="m-2">
                    <label for="labName" class="block"
                        >Nombre del Laboratorio</label
                    >
                    <Input
                        id="labName"
                        inputType="text"
                        placeholder="Mi Laboratorio"
                    />
                </div>
                <div class="m-2">
                    <label class="block">Nombre Completo</label>
                    <Input
                        inputType="text"
                        placeholder="Juan Perez"
                        v-model="username"
                    />
                </div>
                <div class="m-2">
                    <label for="" class="block">E-mail</label>
                    <Input
                        inputType="email"
                        placeholder="hola"
                        v-model="email"
                    />
                </div>
                <div>
                    <label for="" class="block">Contraseña</label>
                    <Input inputType="password" placeholder="*********" />
                </div>
            </form>
            <div class="mt-3">
                <Button
                    @click="handleRegistration"
                    form="registerFrm"
                    class="w-full"
                    content="Prueba boton"
                    color="bg-indigo-500"
                    textColor="text-white"
                />
            </div>
        </div>
    </div>
</template>
