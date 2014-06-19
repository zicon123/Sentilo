/*
 * Sentilo
 * 
 * Copyright (C) 2013 Institut Municipal d’Informàtica, Ajuntament de Barcelona.
 * 
 * This program is licensed and may be used, modified and redistributed under the terms of the
 * European Public License (EUPL), either version 1.1 or (at your option) any later version as soon
 * as they are approved by the European Commission.
 * 
 * Alternatively, you may redistribute and/or modify this program under the terms of the GNU Lesser
 * General Public License as published by the Free Software Foundation; either version 3 of the
 * License, or (at your option) any later version.
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied.
 * 
 * See the licenses for the specific language governing permissions, limitations and more details.
 * 
 * You should have received a copy of the EUPL1.1 and the LGPLv3 licenses along with this program;
 * if not, you may find them at:
 * 
 * https://joinup.ec.europa.eu/software/page/eupl/licence-eupl http://www.gnu.org/licenses/ and
 * https://www.gnu.org/licenses/lgpl.txt
 */
package org.sentilo.platform.client.test.service;

import static org.mockito.Matchers.any;
import static org.mockito.Mockito.verify;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.sentilo.common.rest.RESTClient;
import org.sentilo.platform.client.core.domain.SubscribeInputMessage;
import org.sentilo.platform.client.core.parser.SubscribeMessageConverter;
import org.sentilo.platform.client.core.service.impl.DefaultSubscribeServiceOperationsImpl;


public class DefaultSubscribeServiceOperationsImplTest {

  @InjectMocks
  private DefaultSubscribeServiceOperationsImpl service;

  @Mock
  private RESTClient restClient;

  @Mock
  private SubscribeInputMessage message;

  @Mock
  private SubscribeMessageConverter converter;

  @Before
  public void setUp() {
    MockitoAnnotations.initMocks(this);
  }

  @Test
  public void remove() {
    service.remove(message);

    verify(restClient).delete(any(String.class), any(String.class));
  }

  @Test
  public void get() {
    service.get(message);

    verify(restClient).get(any(String.class), any(String.class));
    verify(converter).unmarshall(any(String.class));
  }

  @Test
  public void subscribe() {
    service.subscribe(message);

    verify(restClient).put(any(String.class), any(String.class), any(String.class));
  }
}