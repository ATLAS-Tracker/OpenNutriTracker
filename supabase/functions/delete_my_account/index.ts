import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.0.0";

console.log("Delete user account function up and running");

serve(async (req) => {
  try {
    //Create instance of SupabaseClient
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "",
    );

    // Get the authorization header from the request.
    // When you invoke the function via the client library
    // it will automatically pass the authenticated user's JWT.
    const authHeader = req.headers.get("Authorization");

    // Get JWT from auth header
    const jwt = authHeader.replace("Bearer ", "");

    // Get the user object
    const {
      data: { user },
    } = await supabaseClient.auth.getUser(jwt);

    if (!user) throw new Error("No user found for JWT!");

    const userId = user.id;

    // Supprimer le dossier dans le bucket 'exports' (nom du dossier = user.id)
    const { error: storageError } = await supabaseClient
      .storage
      .from("exports")
      .remove([`${userId}/`]); // Remarque: le "/" est important pour indiquer un dossier

    if (storageError) {
      console.error("Error :", storageError.message);
      throw new Error("Failed to delete storage folder.");
    }

    //Call deleteUser method and pass user's ID
    const { data, error } = await supabaseClient.auth.admin.deleteUser(user.id);

    return new Response(JSON.stringify(data), {
      headers: { "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    return new Response(JSON.stringify(error), {
      headers: { "Content-Type": "application/json" },
      status: 400,
    });
  }
});