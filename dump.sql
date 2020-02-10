--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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
    channel_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.channel_member OWNER TO chaudinh;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.channels (
    id integer NOT NULL,
    name character varying(255),
    public boolean DEFAULT true,
    dm boolean DEFAULT false,
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
-- Name: member; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.member (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE public.member OWNER TO chaudinh;

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
    url character varying(255),
    filetype character varying(255),
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
-- Name: private_members; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.private_members (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE public.private_members OWNER TO chaudinh;

--
-- Name: privatemembers; Type: TABLE; Schema: public; Owner: chaudinh
--

CREATE TABLE public.privatemembers (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE public.privatemembers OWNER TO chaudinh;

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

COPY public.channel_member (created_at, updated_at, channel_id, user_id) FROM stdin;
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.channels (id, name, public, dm, created_at, updated_at, team_id) FROM stdin;
1	general	t	f	2020-02-10 20:31:57.083+07	2020-02-10 20:31:57.083+07	1
2	general	t	f	2020-02-10 20:32:36.336+07	2020-02-10 20:32:36.336+07	2
3	general	t	f	2020-02-10 20:33:00.953+07	2020-02-10 20:33:00.953+07	3
4	general	t	f	2020-02-10 20:33:55.281+07	2020-02-10 20:33:55.281+07	4
5	general	t	f	2020-02-10 20:34:13.946+07	2020-02-10 20:34:13.946+07	5
6	general	t	f	2020-02-10 20:34:35.984+07	2020-02-10 20:34:35.984+07	6
7	general	t	f	2020-02-10 20:35:05.788+07	2020-02-10 20:35:05.788+07	7
8	general	t	f	2020-02-10 20:35:42.797+07	2020-02-10 20:35:42.797+07	8
9	general	t	f	2020-02-10 20:36:09.26+07	2020-02-10 20:36:09.26+07	9
\.


--
-- Data for Name: direct_messages; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.direct_messages (id, text, created_at, updated_at, team_id, receiver_id, sender_id) FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.member (created_at, updated_at, user_id, team_id) FROM stdin;
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.members (admin, created_at, updated_at, user_id, team_id) FROM stdin;
t	2020-02-10 20:31:57.102+07	2020-02-10 20:31:57.102+07	1	1
t	2020-02-10 20:32:36.339+07	2020-02-10 20:32:36.339+07	2	2
t	2020-02-10 20:33:00.956+07	2020-02-10 20:33:00.956+07	3	3
t	2020-02-10 20:33:55.285+07	2020-02-10 20:33:55.285+07	4	4
t	2020-02-10 20:34:13.948+07	2020-02-10 20:34:13.948+07	5	5
t	2020-02-10 20:34:35.986+07	2020-02-10 20:34:35.986+07	6	6
t	2020-02-10 20:35:05.792+07	2020-02-10 20:35:05.792+07	7	7
t	2020-02-10 20:35:42.8+07	2020-02-10 20:35:42.8+07	8	8
t	2020-02-10 20:36:09.263+07	2020-02-10 20:36:09.263+07	9	9
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.messages (id, text, url, filetype, created_at, updated_at, channel_id, user_id) FROM stdin;
1	welcome every body! 	\N	\N	2020-02-10 20:32:07.853+07	2020-02-10 20:32:07.853+07	1	1
2	this is the site created by React.JS and Node.JS	\N	\N	2020-02-10 20:32:16.929+07	2020-02-10 20:32:16.929+07	1	1
\.


--
-- Data for Name: private_members; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.private_members (created_at, updated_at, user_id, channel_id) FROM stdin;
\.


--
-- Data for Name: privatemembers; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.privatemembers (created_at, updated_at, user_id, channel_id) FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.teams (id, name, created_at, updated_at) FROM stdin;
1	bob's team	2020-02-10 20:31:57.079+07	2020-02-10 20:31:57.079+07
2	susy's	2020-02-10 20:32:36.333+07	2020-02-10 20:32:36.333+07
3	peter's notification	2020-02-10 20:33:00.949+07	2020-02-10 20:33:00.949+07
4	john	2020-02-10 20:33:55.278+07	2020-02-10 20:33:55.278+07
5	my	2020-02-10 20:34:13.942+07	2020-02-10 20:34:13.942+07
6	chau's	2020-02-10 20:34:35.981+07	2020-02-10 20:34:35.981+07
7	call me chau's	2020-02-10 20:35:05.785+07	2020-02-10 20:35:05.785+07
8	lucy	2020-02-10 20:35:42.794+07	2020-02-10 20:35:42.794+07
9	ben awad	2020-02-10 20:36:09.258+07	2020-02-10 20:36:09.258+07
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.users (id, username, email, password, created_at, updated_at) FROM stdin;
1	bob	bob@bob.com	$2b$12$N7NkaEjZbbvuMt.pQP3lf.XzArrY/xxpt3L8M8Fmjm071GPHRQAjG	2020-02-10 20:31:51.858+07	2020-02-10 20:31:51.858+07
2	susy	susy@susy.com	$2b$12$lug3X5HkSsNgmqIs0f74V.Ns7vnEZAZQas8ZGEv4OgQyEGuYwNory	2020-02-10 20:32:32.071+07	2020-02-10 20:32:32.071+07
3	peter	peter@peter.com	$2b$12$InVFM1rpxC8HpZExfMmMbuHWGPPy.PfIkWUyT4XX3Xt9ISc4xWMQK	2020-02-10 20:32:50.535+07	2020-02-10 20:32:50.535+07
4	john	john@john.com	$2b$12$EuRxGuuUk2TYkf4MZbyDVuRMjCZI/VzZqSwkj92nVsxF8tR1QzumC	2020-02-10 20:33:51.907+07	2020-02-10 20:33:51.907+07
5	hoan my	my@my.com	$2b$12$2SRj2UpW.Pm1zxjNjDarI.raM3ltFG9hZW8PP9v.zAgBd6MQq2uGG	2020-02-10 20:34:11.125+07	2020-02-10 20:34:11.125+07
6	dinh chau	chaudvb95uc@gmail.com	$2b$12$lfiCN2c5SV9LHrzLq1TzteoQWR5f4JkEZDMdRAiyaR0nPU8NWvN9u	2020-02-10 20:34:32.85+07	2020-02-10 20:34:32.85+07
7	callmechau	callmechau@callmechau.com	$2b$12$7rQRCqgda7baqyhksSPbtOWQvAvReOLZu7PMJxAsL7E6yU0/ibMfW	2020-02-10 20:34:55.895+07	2020-02-10 20:34:55.895+07
8	lucy	lucy@lucy.com	$2b$12$x40uLsr2Ns4nqfDWbLaIjeuLnV8/KPcNC1HqDvRIGy.QxepR3zjxe	2020-02-10 20:35:39.648+07	2020-02-10 20:35:39.648+07
9	ben awad	ben@ben.com	$2b$12$WWedC66NpXYlW3KDS6aa0.NfIbRGL64cjlupkk2TneBXFJCTBZxr6	2020-02-10 20:36:05.111+07	2020-02-10 20:36:05.111+07
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.channels_id_seq', 9, true);


--
-- Name: direct_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.direct_messages_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.messages_id_seq', 2, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.teams_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- Name: channel_member channel_member_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.channel_member
    ADD CONSTRAINT channel_member_pkey PRIMARY KEY (channel_id, user_id);


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
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (user_id, team_id);


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
-- Name: private_members private_members_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.private_members
    ADD CONSTRAINT private_members_pkey PRIMARY KEY (user_id, channel_id);


--
-- Name: privatemembers privatemembers_pkey; Type: CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.privatemembers
    ADD CONSTRAINT privatemembers_pkey PRIMARY KEY (user_id, channel_id);


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
-- Name: messages_created_at; Type: INDEX; Schema: public; Owner: chaudinh
--

CREATE INDEX messages_created_at ON public.messages USING btree (created_at);


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
-- Name: private_members private_members_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.private_members
    ADD CONSTRAINT private_members_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: private_members private_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chaudinh
--

ALTER TABLE ONLY public.private_members
    ADD CONSTRAINT private_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

