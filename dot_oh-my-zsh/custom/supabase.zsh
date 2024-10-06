if [ "$(command -v supabase)" ]; then
  supabase completion zsh > "${fpath[1]}/_supabase"
fi