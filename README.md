# Data Cleaning – Fuel Station

## Business Problem
The Fuel Station database was originally designed with separate tables for driver emails and phone numbers (DriverEmails, DriverPhoneNumbers). While this normalized approach was correct from a relational perspective, in practice most drivers have only one or two contact details.  

This led to several issues:
- Reports and queries became unnecessarily complex, requiring multiple joins and aggregations.
- Business users struggled with slow analytics and complicated data access.
- Applications (e.g., .NET services using [Dapper](ca://s?q=.NET_Dapper_SQL_Server), [Entity Framework Core](ca://s?q=Entity_Framework_Core_SQL_Server), ETL jobs) had to work with multiple tables, increasing complexity and risk of errors.

## Business Goal
- Simplify data access by consolidating emails and phone numbers directly into the Drivers table.
- Enable faster reporting and easier integration with applications.
- Retain original tables for backward compatibility with existing procedures and external systems.
- Extend cleaning tasks to cover structured data sources such as JSON and XML.

## Outcome
- Drivers have consolidated contact information in a single table.
- Business users can generate reports more easily.
- IT teams maintain backups and fallback options.
- Applications continue to function without disruption.
