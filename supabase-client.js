// ضع بيانات مشروعك من: Supabase Dashboard > Project Settings > API
const SUPABASE_URL = 'https://fnasmumeivvrischdfsv.supabase.co/rest/v1/';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZuYXNtdW1laXZ2cmlzY2hkZnN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTM5NjUxNjEsImV4cCI6MjEwOTU0MTE2MX0.K4-7THbHh_NDRHMCftMOLBFepVX4NogwC2NCivdegkw'; // مفتاح anon فقط - لا تضع service_role هنا أبدًا
window.sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
