﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.ComponentModel;
using System.Data.EntityClient;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Runtime.Serialization;
using System.Xml.Serialization;

[assembly: EdmSchemaAttribute()]
namespace WebsiteTesting.Entities
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class SaovietCheckInEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new SaovietCheckInEntities object using the connection string found in the 'SaovietCheckInEntities' section of the application configuration file.
        /// </summary>
        public SaovietCheckInEntities() : base("name=SaovietCheckInEntities", "SaovietCheckInEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SaovietCheckInEntities object.
        /// </summary>
        public SaovietCheckInEntities(string connectionString) : base(connectionString, "SaovietCheckInEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new SaovietCheckInEntities object.
        /// </summary>
        public SaovietCheckInEntities(EntityConnection connection) : base(connection, "SaovietCheckInEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
    }

    #endregion

    
}
