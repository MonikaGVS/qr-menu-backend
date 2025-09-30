--
-- PostgreSQL database dump
--

\restrict 6B5bEEzQ6vDxCG9SRCUMfUsgCvOOMBWvfVDHJE4FVkZ8j4e7EzHvIfTP1Jf9eEV

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Assignment" (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "waiterId" integer NOT NULL,
    "assignedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Assignment" OWNER TO postgres;

--
-- Name: Assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Assignment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Assignment_id_seq" OWNER TO postgres;

--
-- Name: Assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Assignment_id_seq" OWNED BY public."Assignment".id;


--
-- Name: Customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customer" (
    id integer NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "restaurantId" integer NOT NULL
);


ALTER TABLE public."Customer" OWNER TO postgres;

--
-- Name: Customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Customer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Customer_id_seq" OWNER TO postgres;

--
-- Name: Customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Customer_id_seq" OWNED BY public."Customer".id;


--
-- Name: MenuCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MenuCategory" (
    id integer NOT NULL,
    name text NOT NULL,
    "restaurantId" integer NOT NULL
);


ALTER TABLE public."MenuCategory" OWNER TO postgres;

--
-- Name: MenuCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MenuCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."MenuCategory_id_seq" OWNER TO postgres;

--
-- Name: MenuCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MenuCategory_id_seq" OWNED BY public."MenuCategory".id;


--
-- Name: MenuItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MenuItem" (
    id integer NOT NULL,
    name text NOT NULL,
    price double precision NOT NULL,
    "isAvailable" boolean DEFAULT true NOT NULL,
    "restaurantId" integer NOT NULL,
    "categoryId" integer NOT NULL
);


ALTER TABLE public."MenuItem" OWNER TO postgres;

--
-- Name: MenuItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MenuItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."MenuItem_id_seq" OWNER TO postgres;

--
-- Name: MenuItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MenuItem_id_seq" OWNED BY public."MenuItem".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    status text DEFAULT 'PLACED'::text NOT NULL,
    total double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "restaurantId" integer NOT NULL,
    "tableId" integer NOT NULL,
    "customerId" integer NOT NULL
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItem" (
    id integer NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" double precision NOT NULL,
    "orderId" integer NOT NULL,
    "menuItemId" integer NOT NULL
);


ALTER TABLE public."OrderItem" OWNER TO postgres;

--
-- Name: OrderItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderItem_id_seq" OWNER TO postgres;

--
-- Name: OrderItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_id_seq" OWNED BY public."OrderItem".id;


--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Order_id_seq" OWNER TO postgres;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: Restaurant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Restaurant" (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    phone text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Restaurant" OWNER TO postgres;

--
-- Name: Restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Restaurant_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Restaurant_id_seq" OWNER TO postgres;

--
-- Name: Restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Restaurant_id_seq" OWNED BY public."Restaurant".id;


--
-- Name: Table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Table" (
    id integer NOT NULL,
    number integer NOT NULL,
    "qrUrl" text,
    "restaurantId" integer NOT NULL
);


ALTER TABLE public."Table" OWNER TO postgres;

--
-- Name: Table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Table_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Table_id_seq" OWNER TO postgres;

--
-- Name: Table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Table_id_seq" OWNED BY public."Table".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    role text NOT NULL,
    "restaurantId" integer
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Assignment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignment" ALTER COLUMN id SET DEFAULT nextval('public."Assignment_id_seq"'::regclass);


--
-- Name: Customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer" ALTER COLUMN id SET DEFAULT nextval('public."Customer_id_seq"'::regclass);


--
-- Name: MenuCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuCategory" ALTER COLUMN id SET DEFAULT nextval('public."MenuCategory_id_seq"'::regclass);


--
-- Name: MenuItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuItem" ALTER COLUMN id SET DEFAULT nextval('public."MenuItem_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: OrderItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN id SET DEFAULT nextval('public."OrderItem_id_seq"'::regclass);


--
-- Name: Restaurant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Restaurant" ALTER COLUMN id SET DEFAULT nextval('public."Restaurant_id_seq"'::regclass);


--
-- Name: Table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Table" ALTER COLUMN id SET DEFAULT nextval('public."Table_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Assignment" (id, "orderId", "waiterId", "assignedAt") FROM stdin;
1	1	1	2025-09-27 20:41:32.299
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Customer" (id, name, phone, "createdAt", "restaurantId") FROM stdin;
1	Testing	9876543210	2025-09-27 19:40:37.555	1
2	Chinnu	9874561230	2025-09-27 20:59:56.947	1
3	TestData1	9873216540	2025-09-27 21:00:47.483	1
4	Monika	9987654321	2025-09-27 21:43:01.053	1
\.


--
-- Data for Name: MenuCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MenuCategory" (id, name, "restaurantId") FROM stdin;
1	Starters	1
2	Main Course	1
3	Starters	1
4	Starters	1
5	Main Course	1
\.


--
-- Data for Name: MenuItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MenuItem" (id, name, price, "isAvailable", "restaurantId", "categoryId") FROM stdin;
1	Spring Rolls	120	t	1	1
2	Grilled Chicken	350	t	1	2
3	Paneer Butter Masala	280	t	1	2
4	Spring Rolls	120	t	1	1
5	Grilled Chicken	350	t	1	2
6	Paneer Butter Masala	280	t	1	2
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, status, total, "createdAt", "restaurantId", "tableId", "customerId") FROM stdin;
1	ASSIGNED	120	2025-09-27 19:40:37.565	1	1	1
2	PLACED	120	2025-09-27 20:59:56.953	1	1	2
3	PLACED	470	2025-09-27 21:00:47.485	1	2	3
4	PLACED	470	2025-09-27 21:43:01.057	1	2	4
\.


--
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrderItem" (id, quantity, "unitPrice", "orderId", "menuItemId") FROM stdin;
1	1	120	1	1
2	1	120	2	1
3	1	120	3	4
4	1	350	3	2
5	1	120	4	1
6	1	350	4	2
\.


--
-- Data for Name: Restaurant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Restaurant" (id, name, slug, phone, "createdAt") FROM stdin;
1	Tasty Bites	tasty-bites	9876543210	2025-09-27 01:21:22.367
\.


--
-- Data for Name: Table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Table" (id, number, "qrUrl", "restaurantId") FROM stdin;
1	1	\N	1
2	2	\N	1
3	1	\N	1
4	2	\N	1
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, email, "passwordHash", role, "restaurantId") FROM stdin;
1	Ram	ram@restaurant.com	pass123	WAITER	1
2	Jai	jai@restaurant.com	pass123	WAITER	1
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
41073737-2889-4cdf-9e18-ca25557563f6	bfaddaddcf97f8217c966ed6e106e0ce663684cf9ece2600493eefef1bff8ab1	2025-09-27 00:55:34.672984+05:30	20250926192534_init	\N	\N	2025-09-27 00:55:34.600527+05:30	1
3d96f9fc-3293-4d1f-97ab-4738ce28ce7f	a4a063469875ea008971b0dec4818cb6c009e04b2a6d37f2057b7a4268519b16	2025-09-28 01:06:05.002475+05:30	20250927193604_make_phone_unique	\N	\N	2025-09-28 01:06:04.991686+05:30	1
\.


--
-- Name: Assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Assignment_id_seq"', 1, true);


--
-- Name: Customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Customer_id_seq"', 4, true);


--
-- Name: MenuCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MenuCategory_id_seq"', 5, true);


--
-- Name: MenuItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MenuItem_id_seq"', 6, true);


--
-- Name: OrderItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_id_seq"', 6, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 4, true);


--
-- Name: Restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Restaurant_id_seq"', 3, true);


--
-- Name: Table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Table_id_seq"', 4, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 2, true);


--
-- Name: Assignment Assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignment"
    ADD CONSTRAINT "Assignment_pkey" PRIMARY KEY (id);


--
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);


--
-- Name: MenuCategory MenuCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuCategory"
    ADD CONSTRAINT "MenuCategory_pkey" PRIMARY KEY (id);


--
-- Name: MenuItem MenuItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuItem"
    ADD CONSTRAINT "MenuItem_pkey" PRIMARY KEY (id);


--
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: Restaurant Restaurant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Restaurant"
    ADD CONSTRAINT "Restaurant_pkey" PRIMARY KEY (id);


--
-- Name: Table Table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Table"
    ADD CONSTRAINT "Table_pkey" PRIMARY KEY (id);


--
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Assignment_orderId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Assignment_orderId_key" ON public."Assignment" USING btree ("orderId");


--
-- Name: Customer_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Customer_phone_key" ON public."Customer" USING btree (phone);


--
-- Name: Restaurant_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Restaurant_slug_key" ON public."Restaurant" USING btree (slug);


--
-- Name: Assignment Assignment_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignment"
    ADD CONSTRAINT "Assignment_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Customer Customer_restaurantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES public."Restaurant"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MenuCategory MenuCategory_restaurantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuCategory"
    ADD CONSTRAINT "MenuCategory_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES public."Restaurant"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MenuItem MenuItem_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuItem"
    ADD CONSTRAINT "MenuItem_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."MenuCategory"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MenuItem MenuItem_restaurantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MenuItem"
    ADD CONSTRAINT "MenuItem_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES public."Restaurant"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OrderItem OrderItem_menuItemId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_menuItemId_fkey" FOREIGN KEY ("menuItemId") REFERENCES public."MenuItem"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_restaurantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES public."Restaurant"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Order Order_tableId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_tableId_fkey" FOREIGN KEY ("tableId") REFERENCES public."Table"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Table Table_restaurantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Table"
    ADD CONSTRAINT "Table_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES public."Restaurant"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: User User_restaurantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES public."Restaurant"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 6B5bEEzQ6vDxCG9SRCUMfUsgCvOOMBWvfVDHJE4FVkZ8j4e7EzHvIfTP1Jf9eEV

