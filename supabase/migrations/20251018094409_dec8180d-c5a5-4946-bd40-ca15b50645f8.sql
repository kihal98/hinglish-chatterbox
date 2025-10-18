-- Create conversations table to store chat history
CREATE TABLE IF NOT EXISTS public.conversations (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_message TEXT NOT NULL,
  assistant_message TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;

-- Create policy to allow anyone to read conversations (for learning)
CREATE POLICY "Anyone can read conversations"
  ON public.conversations
  FOR SELECT
  USING (true);

-- Create policy to allow anyone to insert conversations
CREATE POLICY "Anyone can insert conversations"
  ON public.conversations
  FOR INSERT
  WITH CHECK (true);

-- Create index for faster lookups
CREATE INDEX idx_conversations_created_at ON public.conversations(created_at DESC);

-- Enable realtime for live updates
ALTER PUBLICATION supabase_realtime ADD TABLE public.conversations;