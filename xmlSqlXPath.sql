-- ALL THE EVENTS
SELECT COUNT(1) as "Total Events"
FROM [something].[dbo].[calendar.event]

--COUNT EVENTS WITH VALUE ASSIGNED
SELECT COUNT(1) as "Audience is populated"
FROM [something].[dbo].[calendar.event]
WHERE [xml].value('(/p/v[. >> (/p/k[. = "audience"])[1]])[1]', 'nvarchar(max)') is not null

--COUNT EVENTS WITHOUT VALUE ASSIGNED
SELECT COUNT(1) as "Audience is not populated"
FROM [something].[dbo].[calendar.event]
WHERE [xml].value('(/p/v[. >> (/p/k[. = "audience"])[1]])[1]', 'nvarchar(max)') is null

-- LIST EVENT ID NEXT TO SINGLE VALUE ASSIGNED
SELECT id as "Event Id",
[xml].value('(/p/v[. >> (/p/k[. = "admission"])[1]])[1]', 'nvarchar(max)') as "Admission"
FROM [something].[dbo].[calendar.event]
WHERE [xml].value('(/p/v[. >> (/p/k[. = "admission"])[1]])[1]', 'nvarchar(max)') is not null

--GET ALL UNIQUE VALUES FOR FIELD
SELECT DISTINCT [xml].value('(/p/v[. >> (/p/k[. = "audience"])[1]])[1]', 'nvarchar(max)') as uniqvalue
FROM [something].[dbo].[calendar.event]

-- COUNT REPETITION OF ASSIGNED VALUES
SELECT COUNT(events.id), vals.uniqvalue
FROM [something].[dbo].[calendar.event] as events,
(
SELECT DISTINCT [xml].value('(/p/v[. >> (/p/k[. = "audience"])[1]])[1]', 'nvarchar(max)') as uniqvalue
FROM [something].[dbo].[calendar.event]
) vals
WHERE [xml].value('(/p/v[. >> (/p/k[. = "audience"])[1]])[1]', 'nvarchar(max)') is not null
AND [xml].value('(/p/v[. >> (/p/k[. = "audience"])[1]])[1]', 'nvarchar(max)') = vals.uniqvalue
GROUP BY vals.uniqvalue
ORDER BY COUNT(events.id)
