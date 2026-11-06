-- شغّل هذا الملف في Supabase > SQL Editor
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text, civil_id text,
  role text not null default 'teacher',
  is_active boolean not null default true,
  created_at timestamptz default now()
);
alter table public.profiles enable row level security;
create policy "read own profile" on public.profiles
  for select to authenticated using (auth.uid() = id);

create table public.school_news (
  id uuid primary key default gen_random_uuid(),
  title text, description text, content text, category text, emoji text,
  image_url text, date date, created_at timestamptz default now()
);
create table public.school_activities (
  id uuid primary key default gen_random_uuid(),
  title text, description text, "desc" text, type text, status text,
  date date, event_date date, created_at timestamptz default now()
);
create table public.innovations (
  id uuid primary key default gen_random_uuid(),
  title text, description text, "desc" text, icon text, num text, tag text,
  created_at timestamptz default now()
);
create table public.participations (
  id uuid primary key default gen_random_uuid(),
  title text, description text, award text, rank text, meta text,
  date date, created_at timestamptz default now()
);
create table public.gallery (
  id uuid primary key default gen_random_uuid(),
  title text, emoji text, image_url text, created_at timestamptz default now()
);

do $$
declare t text;
begin
  foreach t in array array['school_news','school_activities','innovations','participations','gallery'] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('create policy "public read" on public.%I for select to anon, authenticated using (true)', t);
    execute format($p$create policy "admin write" on public.%I for all to authenticated
      using (exists (select 1 from public.profiles p where p.id = auth.uid() and p.role in ('admin','it_admin','activities_spec')))
      with check (exists (select 1 from public.profiles p where p.id = auth.uid() and p.role in ('admin','it_admin','activities_spec')))$p$, t);
  end loop;
end $$;
