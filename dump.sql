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
1	general	t	f	2019-08-10 21:37:10.926+07	2019-08-10 21:37:10.926+07	1
2	bob2, bob3, bob4	f	t	2019-08-10 21:38:55.197+07	2019-08-10 21:38:55.197+07	1
3	general	t	f	2019-08-10 22:20:46.808+07	2019-08-10 22:20:46.808+07	2
4	bob	f	t	2019-08-10 22:21:19.296+07	2019-08-10 22:21:19.296+07	2
5	random	t	f	2019-08-10 22:26:10.782+07	2019-08-10 22:26:10.782+07	1
6	test	t	f	2019-08-10 22:28:51.752+07	2019-08-10 22:28:51.752+07	1
7	test2	t	f	2019-08-10 22:29:31.735+07	2019-08-10 22:29:31.735+07	1
8	general	t	f	2019-08-13 19:59:29.072+07	2019-08-13 19:59:29.072+07	3
9	bob3, bob4	f	t	2019-08-13 20:21:00.916+07	2019-08-13 20:21:00.916+07	1
10	general	t	f	2019-08-13 21:04:28.174+07	2019-08-13 21:04:28.174+07	4
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
t	2019-08-10 21:37:10.93+07	2019-08-10 21:37:10.93+07	1	1
f	2019-08-10 21:38:11.26+07	2019-08-10 21:38:11.26+07	2	1
f	2019-08-10 21:38:24.495+07	2019-08-10 21:38:24.495+07	3	1
f	2019-08-10 21:38:31.967+07	2019-08-10 21:38:31.967+07	4	1
t	2019-08-10 22:20:46.812+07	2019-08-10 22:20:46.812+07	2	2
f	2019-08-10 22:20:57.57+07	2019-08-10 22:20:57.57+07	1	2
t	2019-08-13 19:59:29.076+07	2019-08-13 19:59:29.076+07	1	3
t	2019-08-13 21:04:28.177+07	2019-08-13 21:04:28.177+07	3	4
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.messages (id, text, url, filetype, created_at, updated_at, channel_id, user_id) FROM stdin;
1	hey!	\N	\N	2019-08-10 21:49:54.361+07	2019-08-10 21:49:54.361+07	2	1
2	hello there!	\N	\N	2019-08-10 22:17:34.551+07	2019-08-10 22:17:34.551+07	2	1
3	this message is subbed by redis	\N	\N	2019-08-10 22:18:59.18+07	2019-08-10 22:18:59.18+07	1	1
4	ok	\N	\N	2019-08-10 22:19:44.952+07	2019-08-10 22:19:44.952+07	1	2
5	woa	\N	\N	2019-08-10 22:20:02.07+07	2019-08-10 22:20:02.07+07	1	2
6	hi all	\N	\N	2019-08-10 22:20:07.529+07	2019-08-10 22:20:07.529+07	1	2
7	hello there!	\N	\N	2019-08-10 22:21:38.745+07	2019-08-10 22:21:38.745+07	4	2
8	hi bob2	\N	\N	2019-08-10 22:21:46.431+07	2019-08-10 22:21:46.431+07	4	1
9	hi there!	\N	\N	2019-08-10 22:37:55.578+07	2019-08-10 22:37:55.578+07	1	1
10	this is the test message	\N	\N	2019-08-10 22:38:01.759+07	2019-08-10 22:38:01.759+07	1	1
11	cracking the coding interview	\N	\N	2019-08-10 22:38:07.544+07	2019-08-10 22:38:07.544+07	1	1
12	ahihi	\N	\N	2019-08-10 22:38:10.086+07	2019-08-10 22:38:10.086+07	1	1
13	introduction to algorithms	\N	\N	2019-08-10 22:38:16.487+07	2019-08-10 22:38:16.487+07	1	1
14	boom boom	\N	\N	2019-08-10 22:38:22.504+07	2019-08-10 22:38:22.504+07	1	1
15	baam 	\N	\N	2019-08-10 22:38:24.64+07	2019-08-10 22:38:24.64+07	1	1
16	i'm so hot	\N	\N	2019-08-10 22:38:27.928+07	2019-08-10 22:38:27.928+07	1	1
17	black pink in your area 	\N	\N	2019-08-10 22:38:42.215+07	2019-08-10 22:38:42.215+07	1	1
18	kill this love	\N	\N	2019-08-10 22:38:48.168+07	2019-08-10 22:38:48.168+07	1	1
19	latest message	\N	\N	2019-08-11 20:53:35.619+07	2019-08-11 20:53:35.619+07	1	1
20	even later messages	\N	\N	2019-08-11 21:01:55.323+07	2019-08-11 21:01:55.323+07	1	1
21	last text message	\N	\N	2019-08-11 21:02:28.87+07	2019-08-11 21:02:28.87+07	1	1
22	hello	\N	\N	2019-08-11 22:00:31.303+07	2019-08-11 22:00:31.303+07	1	1
23	hi	\N	\N	2019-08-11 22:01:53.42+07	2019-08-11 22:01:53.42+07	5	1
24	this is the best 	\N	\N	2019-08-11 22:01:56.001+07	2019-08-11 22:01:56.001+07	5	1
25	chat app that i've made	\N	\N	2019-08-11 22:02:11.48+07	2019-08-11 22:02:11.48+07	5	1
26	let's kill this love!	\N	\N	2019-08-12 13:23:37.071+07	2019-08-12 13:23:37.071+07	1	1
27	1	\N	\N	2019-08-12 13:28:27.315+07	2019-08-12 13:28:27.315+07	1	1
28	2	\N	\N	2019-08-12 13:28:27.609+07	2019-08-12 13:28:27.609+07	1	1
29	3	\N	\N	2019-08-12 13:28:27.841+07	2019-08-12 13:28:27.841+07	1	1
30	4	\N	\N	2019-08-12 13:28:28.096+07	2019-08-12 13:28:28.096+07	1	1
31	4	\N	\N	2019-08-12 13:28:28.315+07	2019-08-12 13:28:28.315+07	1	1
32	5	\N	\N	2019-08-12 13:28:28.552+07	2019-08-12 13:28:28.552+07	1	1
33	q	\N	\N	2019-08-12 13:28:28.938+07	2019-08-12 13:28:28.938+07	1	1
34	2	\N	\N	2019-08-12 13:28:29.199+07	2019-08-12 13:28:29.199+07	1	1
35	13	\N	\N	2019-08-12 13:28:29.383+07	2019-08-12 13:28:29.383+07	1	1
36	12	\N	\N	2019-08-12 13:28:29.608+07	2019-08-12 13:28:29.608+07	1	1
37	3	\N	\N	2019-08-12 13:28:29.799+07	2019-08-12 13:28:29.799+07	1	1
38	124	\N	\N	2019-08-12 13:28:30.129+07	2019-08-12 13:28:30.129+07	1	1
39	w	\N	\N	2019-08-12 13:28:30.364+07	2019-08-12 13:28:30.364+07	1	1
40	ef	\N	\N	2019-08-12 13:28:30.823+07	2019-08-12 13:28:30.823+07	1	1
41	1ewd	\N	\N	2019-08-12 13:28:31.719+07	2019-08-12 13:28:31.719+07	1	1
42	35	\N	\N	2019-08-12 13:28:32.35+07	2019-08-12 13:28:32.35+07	1	1
43	1	\N	\N	2019-08-12 13:28:32.792+07	2019-08-12 13:28:32.792+07	1	1
44	wqe9fq	\N	\N	2019-08-12 13:28:33.823+07	2019-08-12 13:28:33.823+07	1	1
45	what	\N	\N	2019-08-12 13:29:36.332+07	2019-08-12 13:29:36.332+07	1	1
46	what's up?	\N	\N	2019-08-12 13:29:45.705+07	2019-08-12 13:29:45.705+07	1	1
47	what's up???	\N	\N	2019-08-12 13:34:02.489+07	2019-08-12 13:34:02.489+07	1	1
48	hi there!	\N	\N	2019-08-12 13:37:22.06+07	2019-08-12 13:37:22.06+07	6	1
49	this is a good day!	\N	\N	2019-08-12 13:37:26.595+07	2019-08-12 13:37:26.595+07	6	1
50	how is it goin	\N	\N	2019-08-12 13:37:29.649+07	2019-08-12 13:37:29.649+07	6	1
51	can we have a little party at night?	\N	\N	2019-08-12 13:37:37.938+07	2019-08-12 13:37:37.938+07	6	1
52	jnas;df	\N	\N	2019-08-12 13:37:44.113+07	2019-08-12 13:37:44.113+07	6	1
53	asdfasdfas	\N	\N	2019-08-12 13:37:44.687+07	2019-08-12 13:37:44.687+07	6	1
54	wejiwef	\N	\N	2019-08-12 13:37:45.585+07	2019-08-12 13:37:45.585+07	6	1
55	asdfijaisd	\N	\N	2019-08-12 13:37:46.336+07	2019-08-12 13:37:46.336+07	6	1
56	wejewih;osdf	\N	\N	2019-08-12 13:37:47.545+07	2019-08-12 13:37:47.545+07	6	1
57	jwnf;kjqwn	\N	\N	2019-08-12 13:37:48.696+07	2019-08-12 13:37:48.696+07	6	1
58	jen;ijwehfiwhfwf	\N	\N	2019-08-12 13:37:50.082+07	2019-08-12 13:37:50.082+07	6	1
59	wlfksndnfnasdf	\N	\N	2019-08-12 13:37:51.248+07	2019-08-12 13:37:51.248+07	6	1
60	awjef;iwuhui4h	\N	\N	2019-08-12 13:37:52.872+07	2019-08-12 13:37:52.872+07	6	1
61	dskjfn;askjdasmdnf	\N	\N	2019-08-12 13:37:54.065+07	2019-08-12 13:37:54.065+07	6	1
62	sdanfn.m,n.zx,mcnv.zxc	\N	\N	2019-08-12 13:37:55.336+07	2019-08-12 13:37:55.336+07	6	1
63	asdkjf;adskjfh	\N	\N	2019-08-12 13:37:56.23+07	2019-08-12 13:37:56.23+07	6	1
64	qwewejrhwehrwerowier	\N	\N	2019-08-12 13:37:57.809+07	2019-08-12 13:37:57.809+07	6	1
65	jkasdfjkahsdfsd	\N	\N	2019-08-12 13:37:59.4+07	2019-08-12 13:37:59.4+07	6	1
66	sadfasf	\N	\N	2019-08-12 13:38:01.656+07	2019-08-12 13:38:01.656+07	6	1
67	sdjkfh;askdh;qwir	\N	\N	2019-08-12 13:38:03.2+07	2019-08-12 13:38:03.2+07	6	1
68	ahihi	\N	\N	2019-08-12 13:38:17.957+07	2019-08-12 13:38:17.957+07	6	1
69	hello	\N	\N	2019-08-12 13:38:29.634+07	2019-08-12 13:38:29.634+07	6	1
70	this is an awesome app for connecting other people	\N	\N	2019-08-12 13:38:45.901+07	2019-08-12 13:38:45.901+07	6	1
71	are you ok?	\N	\N	2019-08-12 13:38:55.378+07	2019-08-12 13:38:55.378+07	6	1
72	this would be the best practiceo	\N	\N	2019-08-12 13:43:51.992+07	2019-08-12 13:43:51.992+07	6	1
73	ds	\N	\N	2019-08-12 13:43:52.763+07	2019-08-12 13:43:52.763+07	6	1
74	12	\N	\N	2019-08-12 13:43:53.481+07	2019-08-12 13:43:53.481+07	6	1
75	asd	\N	\N	2019-08-12 13:43:54.185+07	2019-08-12 13:43:54.185+07	6	1
76	4fsd	\N	\N	2019-08-12 13:43:55.21+07	2019-08-12 13:43:55.21+07	6	1
77	409ifn	\N	\N	2019-08-12 13:43:56.65+07	2019-08-12 13:43:56.65+07	6	1
78	sjkadnfkajsdf	\N	\N	2019-08-12 13:43:57.561+07	2019-08-12 13:43:57.561+07	6	1
79	weh9248	\N	\N	2019-08-12 13:43:58.624+07	2019-08-12 13:43:58.624+07	6	1
80	sdfjkajskdfkajsdhfa	\N	\N	2019-08-12 13:44:07.142+07	2019-08-12 13:44:07.142+07	6	1
81	adsjkfhaksdjfh;asdkj	\N	\N	2019-08-12 13:44:08.017+07	2019-08-12 13:44:08.017+07	6	1
82	sdkfaskdjfhajksdf	\N	\N	2019-08-12 13:44:09.041+07	2019-08-12 13:44:09.041+07	6	1
83	kjsadfkajsdf;jkasdf	\N	\N	2019-08-12 13:44:10.098+07	2019-08-12 13:44:10.098+07	6	1
84	adsfjaskdf;askdjf;askdf	\N	\N	2019-08-12 13:44:11.504+07	2019-08-12 13:44:11.504+07	6	1
85	asdkjf	\N	\N	2019-08-12 13:44:12.055+07	2019-08-12 13:44:12.055+07	6	1
86	sdfjkasdfas	\N	\N	2019-08-12 13:44:12.634+07	2019-08-12 13:44:12.634+07	6	1
87	dfasf	\N	\N	2019-08-12 13:44:13.03+07	2019-08-12 13:44:13.03+07	6	1
88	asdf	\N	\N	2019-08-12 13:44:13.361+07	2019-08-12 13:44:13.361+07	6	1
89	df	\N	\N	2019-08-12 13:44:13.537+07	2019-08-12 13:44:13.537+07	6	1
90	asf	\N	\N	2019-08-12 13:44:13.735+07	2019-08-12 13:44:13.735+07	6	1
91	asf	\N	\N	2019-08-12 13:44:13.919+07	2019-08-12 13:44:13.919+07	6	1
92	asd	\N	\N	2019-08-12 13:44:14.089+07	2019-08-12 13:44:14.089+07	6	1
93	as	\N	\N	2019-08-12 13:44:14.256+07	2019-08-12 13:44:14.256+07	6	1
94	df	\N	\N	2019-08-12 13:44:14.399+07	2019-08-12 13:44:14.399+07	6	1
95	asdf	\N	\N	2019-08-12 13:44:14.548+07	2019-08-12 13:44:14.548+07	6	1
96	as	\N	\N	2019-08-12 13:44:14.679+07	2019-08-12 13:44:14.679+07	6	1
97	fa	\N	\N	2019-08-12 13:44:14.83+07	2019-08-12 13:44:14.83+07	6	1
98	f	\N	\N	2019-08-12 13:44:14.965+07	2019-08-12 13:44:14.965+07	6	1
99	as	\N	\N	2019-08-12 13:44:15.103+07	2019-08-12 13:44:15.103+07	6	1
100	fas	\N	\N	2019-08-12 13:44:16.288+07	2019-08-12 13:44:16.288+07	6	1
101	hey group!	\N	\N	2019-08-12 13:46:26.491+07	2019-08-12 13:46:26.491+07	7	1
102	hello there!	\N	\N	2019-08-13 19:19:59.204+07	2019-08-13 19:19:59.204+07	7	1
103	cracking the coding isadfasdfbasdfasd	\N	\N	2019-08-13 19:20:03.911+07	2019-08-13 19:20:03.911+07	7	1
104	javascript	\N	\N	2019-08-13 19:20:06.152+07	2019-08-13 19:20:06.152+07	7	1
105	hello again 	\N	\N	2019-08-13 19:31:03.438+07	2019-08-13 19:31:03.438+07	1	1
106	nice to meet you!	\N	\N	2019-08-13 19:31:09.873+07	2019-08-13 19:31:09.873+07	1	1
107	blablabla	\N	\N	2019-08-13 20:21:12.243+07	2019-08-13 20:21:12.243+07	9	1
108	hidden message	\N	\N	2019-08-13 20:43:37.698+07	2019-08-13 20:43:37.698+07	1	1
109	ccc\\\\	\N	\N	2019-08-13 20:43:54.443+07	2019-08-13 20:43:54.443+07	1	1
110	baabajsdf	\N	\N	2019-08-13 20:45:39.766+07	2019-08-13 20:45:39.766+07	1	1
111	hey	\N	\N	2019-08-13 20:51:46.635+07	2019-08-13 20:51:46.635+07	1	3
112	hey2	\N	\N	2019-08-13 20:52:40.544+07	2019-08-13 20:52:40.544+07	1	1
113	;faksjdh	\N	\N	2019-08-13 20:54:09.563+07	2019-08-13 20:54:09.563+07	1	1
114	dis mie may	\N	\N	2019-08-13 20:54:58.048+07	2019-08-13 20:54:58.048+07	9	3
115	ahihi	\N	\N	2019-08-13 20:55:01.553+07	2019-08-13 20:55:01.553+07	9	3
116	ds	\N	\N	2019-08-13 21:04:12.52+07	2019-08-13 21:04:12.52+07	5	3
117	d	\N	\N	2019-08-13 21:04:12.681+07	2019-08-13 21:04:12.681+07	5	3
118	sa	\N	\N	2019-08-13 21:04:12.835+07	2019-08-13 21:04:12.835+07	5	3
119	d	\N	\N	2019-08-13 21:04:12.971+07	2019-08-13 21:04:12.971+07	5	3
120	asd	\N	\N	2019-08-13 21:04:13.1+07	2019-08-13 21:04:13.1+07	5	3
122	f	\N	\N	2019-08-13 21:04:13.395+07	2019-08-13 21:04:13.395+07	5	3
123	asdf	\N	\N	2019-08-13 21:04:13.557+07	2019-08-13 21:04:13.557+07	5	3
124	sad	\N	\N	2019-08-13 21:04:13.681+07	2019-08-13 21:04:13.681+07	5	3
125	fsadf	\N	\N	2019-08-13 21:04:13.994+07	2019-08-13 21:04:13.994+07	5	3
127	as	\N	\N	2019-08-13 21:04:14.305+07	2019-08-13 21:04:14.305+07	5	3
128	dfds	\N	\N	2019-08-13 21:04:14.519+07	2019-08-13 21:04:14.519+07	5	3
129	asdd	\N	\N	2019-08-13 21:04:14.995+07	2019-08-13 21:04:14.995+07	5	3
130	sd	\N	\N	2019-08-13 21:04:15.338+07	2019-08-13 21:04:15.338+07	5	3
121	f	\N	\N	2019-08-13 21:04:13.235+07	2019-08-13 21:04:13.235+07	5	3
126	sad	\N	\N	2019-08-13 21:04:14.171+07	2019-08-13 21:04:14.171+07	5	3
131	a	\N	\N	2019-08-13 21:04:31.338+07	2019-08-13 21:04:31.338+07	10	3
132	a	\N	\N	2019-08-13 21:04:31.483+07	2019-08-13 21:04:31.483+07	10	3
133	a	\N	\N	2019-08-13 21:04:31.626+07	2019-08-13 21:04:31.626+07	10	3
134	as	\N	\N	2019-08-13 21:04:31.763+07	2019-08-13 21:04:31.763+07	10	3
135	da	\N	\N	2019-08-13 21:04:31.909+07	2019-08-13 21:04:31.909+07	10	3
136	sd	\N	\N	2019-08-13 21:04:32.028+07	2019-08-13 21:04:32.028+07	10	3
137	sd	\N	\N	2019-08-13 21:04:32.171+07	2019-08-13 21:04:32.171+07	10	3
138	s	\N	\N	2019-08-13 21:04:32.299+07	2019-08-13 21:04:32.299+07	10	3
139	das	\N	\N	2019-08-13 21:04:32.442+07	2019-08-13 21:04:32.442+07	10	3
140	d	\N	\N	2019-08-13 21:04:32.586+07	2019-08-13 21:04:32.586+07	10	3
141	asd	\N	\N	2019-08-13 21:04:32.739+07	2019-08-13 21:04:32.739+07	10	3
142	d	\N	\N	2019-08-13 21:04:32.889+07	2019-08-13 21:04:32.889+07	10	3
143	sad	\N	\N	2019-08-13 21:04:33.057+07	2019-08-13 21:04:33.057+07	10	3
144	asd	\N	\N	2019-08-13 21:04:33.226+07	2019-08-13 21:04:33.226+07	10	3
145	sa	\N	\N	2019-08-13 21:04:33.362+07	2019-08-13 21:04:33.362+07	10	3
146	s	\N	\N	2019-08-13 21:04:33.577+07	2019-08-13 21:04:33.577+07	10	3
147	adbsabfsd	\N	\N	2019-08-13 21:14:15.763+07	2019-08-13 21:14:15.763+07	10	3
148	haha	\N	\N	2019-08-13 21:53:29.972+07	2019-08-13 21:53:29.972+07	10	3
\.


--
-- Data for Name: private_members; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.private_members (created_at, updated_at, user_id, channel_id) FROM stdin;
2019-08-10 21:38:55.204+07	2019-08-10 21:38:55.204+07	2	2
2019-08-10 21:38:55.204+07	2019-08-10 21:38:55.204+07	4	2
2019-08-10 21:38:55.204+07	2019-08-10 21:38:55.204+07	3	2
2019-08-10 21:38:55.204+07	2019-08-10 21:38:55.204+07	1	2
2019-08-10 22:21:19.303+07	2019-08-10 22:21:19.303+07	1	4
2019-08-10 22:21:19.303+07	2019-08-10 22:21:19.303+07	2	4
2019-08-13 20:21:00.925+07	2019-08-13 20:21:00.925+07	3	9
2019-08-13 20:21:00.925+07	2019-08-13 20:21:00.925+07	4	9
2019-08-13 20:21:00.925+07	2019-08-13 20:21:00.925+07	1	9
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
1	my first team 	2019-08-10 21:37:10.921+07	2019-08-10 21:37:10.921+07
2	my team	2019-08-10 22:20:46.802+07	2019-08-10 22:20:46.802+07
3	third team	2019-08-13 19:59:29.051+07	2019-08-13 19:59:29.051+07
4	bob3's team	2019-08-13 21:04:28.171+07	2019-08-13 21:04:28.171+07
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: chaudinh
--

COPY public.users (id, username, email, password, created_at, updated_at) FROM stdin;
1	bob	bob@bob.com	$2b$12$UhSN1B58IEzGOR5wwBpu/.9f/iD1IzVfeu6ELmeVPaVF0EwEBynle	2019-08-10 21:37:01.745+07	2019-08-10 21:37:01.745+07
2	bob2	bob2@bob.com	$2b$12$I.D.eFIJheOtPvg2jIc/iebqKW9PfOE/esP8hoYOqVLhyKEvkVTVi	2019-08-10 21:37:29.328+07	2019-08-10 21:37:29.328+07
3	bob3	bob3@bob.com	$2b$12$XHYuJwe/XvmDwLjNHY4INeIadR0GERSe1y2ohpzIoAUNX7.xxpr.W	2019-08-10 21:37:39.151+07	2019-08-10 21:37:39.151+07
4	bob4	bob4@bob.com	$2b$12$bQpjwU2zOslRuP6T0TMaKerAsneZImpMDyBTeDw.wab70ruEvdK9O	2019-08-10 21:37:53.475+07	2019-08-10 21:37:53.475+07
\.


--
-- Name: channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.channels_id_seq', 10, true);


--
-- Name: direct_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.direct_messages_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.messages_id_seq', 148, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.teams_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chaudinh
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


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

