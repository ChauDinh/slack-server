--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channel_member; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.channel_member (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE public.channel_member OWNER TO chaudinh;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.channels (
    id integer NOT NULL,
    name character varying(255),
    public boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    team_id integer
);


ALTER TABLE public.channels OWNER TO chaudinh;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: chaudinh
--

CREATE SEQUENCE public.channels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channels_id_seq OWNER TO chaudinh;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chaudinh
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: direct_messages; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.direct_messages (
    id integer NOT NULL,
    text character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    team_id integer,
    receiver_id integer,
    sender_id integer
);


ALTER TABLE public.direct_messages OWNER TO chaudinh;

--
-- Name: direct_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: chaudinh
--

CREATE SEQUENCE public.direct_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.direct_messages_id_seq OWNER TO chaudinh;

--
-- Name: direct_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chaudinh
--

ALTER SEQUENCE public.direct_messages_id_seq OWNED BY public.direct_messages.id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.members (
    admin boolean DEFAULT false,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE public.members OWNER TO chaudinh;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    text character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    channel_id integer,
    user_id integer
);


ALTER TABLE public.messages OWNER TO chaudinh;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: chaudinh
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO chaudinh;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chaudinh
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.teams (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.teams OWNER TO chaudinh;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: chaudinh
--

CREATE SEQUENCE public.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO chaudinh;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chaudinh
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    password character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO chaudinh;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: chaudinh
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO chaudinh;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chaudinh
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: direct_messages id; Type: DEFAULT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.direct_messages ALTER COLUMN id SET DEFAULT nextval('public.direct_messages_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: channel_member; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.channel_member (created_at, updated_at, user_id, channel_id) FROM stdin;
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.channels (id, name, public, created_at, updated_at, team_id) FROM stdin;
1	general	t	2019-08-05 23:15:39.803+07	2019-08-05 23:15:39.803+07	1
\.


--
-- Data for Name: direct_messages; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.direct_messages (id, text, created_at, updated_at, team_id, receiver_id, sender_id) FROM stdin;
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.members (admin, created_at, updated_at, user_id, team_id) FROM stdin;
t	2019-08-05 23:15:39.808+07	2019-08-05 23:15:39.808+07	1	1
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.messages (id, text, created_at, updated_at, channel_id, user_id) FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.teams (id, name, created_at, updated_at) FROM stdin;
1	team1	2019-08-05 23:15:39.782+07	2019-08-05 23:15:39.782+07
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.users (id, username, email, password, created_at, updated_at) FROM stdin;
1	testuser	testuser@testuser.com	$2b$12$nmSv95EDDA7Zw0xrwpzO2uZ14oIebK8E3u/u9QV2uVp8w4A2N12Pi	2019-08-05 23:15:30.86+07	2019-08-05 23:15:30.86+07
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.channels_id_seq', 1, true);


--
-- Name: direct_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.direct_messages_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.teams_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: channel_member channel_member_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channel_member
    ADD CONSTRAINT channel_member_pkey PRIMARY KEY (user_id, channel_id);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: direct_messages direct_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.direct_messages
    ADD CONSTRAINT direct_messages_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (user_id, team_id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: channel_member channel_member_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channel_member
    ADD CONSTRAINT channel_member_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: channel_member channel_member_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channel_member
    ADD CONSTRAINT channel_member_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: channels channels_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: direct_messages direct_messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.direct_messages
    ADD CONSTRAINT direct_messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: direct_messages direct_messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.direct_messages
    ADD CONSTRAINT direct_messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: direct_messages direct_messages_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.direct_messages
    ADD CONSTRAINT direct_messages_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: members members_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: members members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages messages_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

