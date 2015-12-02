SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

DROP VIEW public.statistics_sessions;
SET search_path = public, pg_catalog;

SET default_tablespace = '';

--
-- Name: statistics_sessions; Type: MATERIALIZED VIEW; Schema: public; Owner: euphorie2; Tablespace: 
--

CREATE MATERIALIZED VIEW statistics_sessions AS
 SELECT c.session_id,
    round(COALESCE(a.answered_ratio, (0)::numeric), 2) AS answered_ratio,
    round(COALESCE(b.action_ratio, (0)::numeric), 2) AS action_ratio
   FROM ((( SELECT visible_risks.session_id,
            ((count(visible_risks.identification))::numeric / (count(visible_risks.id))::numeric) AS answered_ratio
           FROM visible_risks
          GROUP BY visible_risks.session_id) a
     FULL JOIN ( SELECT a_1.session_id,
            ((count(NULLIF(a_1.measures, 0)))::numeric / (count(a_1.measures))::numeric) AS action_ratio
           FROM ( SELECT visible_risks.session_id,
                    count(action_plan.id) AS measures
                   FROM (visible_risks
                     LEFT JOIN action_plan ON ((visible_risks.id = action_plan.risk_id)))
                  WHERE (((visible_risks.identification)::text = 'no'::text) OR ((visible_risks.risk_type)::text = 'top5'::text))
                  GROUP BY visible_risks.session_id, visible_risks.id) a_1
          GROUP BY a_1.session_id) b ON ((a.session_id = b.session_id)))
     RIGHT JOIN ( SELECT session.id AS session_id
           FROM session) c ON (((a.session_id = c.session_id) OR (b.session_id = c.session_id))))
  WITH NO DATA;


ALTER TABLE public.statistics_sessions OWNER TO euphorie2;

--
-- Name: statistics_sessions; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: euphorie2
--

REFRESH MATERIALIZED VIEW statistics_sessions;
